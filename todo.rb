# list of commands to use:
# add string
# remove id
# finish id
# reopen id
# reorder id id
# next
# list

require 'csv'

def read_file
  CSV.parse(File.read('todos.csv'), headers: false)
end

def write_to_file(items)
  CSV.open('todos.csv', 'w') do |csv|
    items.each do |item|
      csv << [item[0], item[1]]
    end
  end
end

def append_to_file(item)
  CSV.open('todos.csv', 'a') do |csv|
    csv << [item, "false"]
  end
end

def length_of_frame
  items = read_file
  items_temp = []
  items.each do |item|
    items_temp.push item.to_s
  end
  
  items_temp = items_temp.sort_by {|x| x.length}
  hr = "--------" 
  items_temp.last.length.times do 
    hr += '-'
  end
  return hr
end

def list_items
  items = read_file
  hr = length_of_frame
  puts hr
  items.each_with_index do |row, index|
    if row[1] == "true"
      puts "#{index + 1}) [x] #{row[0]}"
    else
      puts "#{index + 1}) [] #{row[0]}"
    end
  end
  puts hr
end

commandName = ARGV[0]
case commandName
  when "add"
    todoName = ARGV[1].to_s
    append_to_file(todoName)
    list_items
  when "list"
    list_items
  when "finish"
    id = ARGV[1]
    items = read_file
    if id
      items[id.to_i - 1][1] = "true"
    end
    write_to_file(items)
    list_items
  when "reopen"
    id = ARGV[1]
    items = read_file
    if id
      items[id.to_i - 1][1] = "false"
    end
    write_to_file(items)
    list_items
  when "next"
    items = read_file
    items.each do |row|
      if row[1] == "false"
        puts "[] #{row[0]}"
        break
      end
    end
  when "reorder"
    items = read_file
    id_first = ARGV[1].to_i - 1
    id_second = ARGV[2].to_i - 1
    items[id_first], items[id_second] = items[id_second], items[id_first]
    write_to_file(items)
    list_items
  when "remove"
    id = ARGV[1].to_i - 1
    items = read_file
    items.delete_at(id)
    write_to_file(items)
    list_items
end
