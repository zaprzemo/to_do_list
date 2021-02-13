# list of commands to use:
# add string
# remove id
# finish id
# reopen id
# reorder id id
# next
# list

require 'csv'
class File
  def read_file
    CSV.parse(File.read(file), headers: false)
  end
  def file_name
    p file
  end 
  def append_to_file(item)
    CSV.open(file, 'a') do |csv|
    csv << [item, "false"]
    end
  end
  def add(attrs)
    append_to_file(attrs)
  end

  def write_to_file(items)
    CSV.open(file, 'w') do |csv|
    items.each do |item|
      csv << [item[0], item[1]]
    end
    end
  end
end
class Todo < File
  attr_accessor :file
  def initialize(name)
    @file = name
  end

  def finish(id)
    items = read_file
    if id
      items[id.to_i - 1][1] = "true"
    end
    write_to_file(items)
  end
  def next_todo
    items = read_file
    items.each do |row|
      if row[1] == "false"
      p "[] #{row[0]}"
      break
      end
    end
  end
  def reorder(id1, id2)
    items = read_file
    items[id1], items[id2] = items[id2], items[id1]
    write_to_file(items)
  end
  def reopen(id)
    items = read_file
    if id
      items[id.to_i - 1][1] = "false"
    end
    write_to_file(items)
  end
  def remove(id)
    items = read_file
    items.delete_at(id)
    write_to_file(items)
  end
  def list_items
    items = self.read_file
    hr = length_of_frame
    p hr
    items.each_with_index do |row, index|
    if row[1] == "true"
      p "#{(index + 1).to_s}) [x] #{row[0].to_s}"
    else
      p "#{(index + 1).to_s}) [] #{row[0].to_s}"
    end
    end
    p hr
  end
  def length_of_frame
    items = read_file
    items_temp = []
    items.each do |item, status|
    items_temp<<item.to_s
    end
    items_temp = items_temp.sort_by {|x| x.length}
    hr = "--------" 
    items_temp.last.length.times do 
    hr += '-'
    end
    return hr
  end
end

todo = Todo.new('todos.csv')

commandName = ARGV[0]
case commandName
  when "add"
    todo.add(ARGV[1].to_s)
    todo.list_items
  when "list"
    todo.list_items
  when "finish"
    todo.finish(ARGV[1])
    todo.list_items
  when "reopen"
    todo.reopen(ARGV[1])
    todo.list_items
  when "next"
  todo.next_todo
  when "reorder"
    todo.reorder(ARGV[1].to_i - 1,ARGV[2].to_i - 1)
    todo.list_items
  when "remove"
    todo.remove(ARGV[1].to_i - 1)
    todo.list_items
end
