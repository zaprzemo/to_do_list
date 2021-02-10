# syntax:
## ruby todo.rb COMMAND
## list of available COMMANDS to use:
### add string - adds a new task to the list
`ruby todo.rb add "XYZ"`

```
----------
1) [] XYZ
----------
```

### finish id - marks as finished
`ruby todo.rb finish 1`

```
----------
1) [x] XYZ
----------
```
### reopen id - reopens task
`ruby todo.rb reopen 1`

```
----------
1) [] XYZ
----------
```
### remove id - remove task
`ruby todo.rb remove 1`

```
----------

----------
```
### reorder id id - reorders tasks
`ruby todo.rb reorder 1 2
Before
```
----------
1) [] XYZ
2) [] JKL
----------
```
after
```
----------
1) [] JKL
2) [] XYZ
----------
```
### next - shows next task to do
```
----------
1) [x] JKL
2) [] XYZ
----------
```
will show 
[] XYZ
### list - lists all tasks 
```
----------
1) [x] JKL
2) [] XYZ
----------
```
