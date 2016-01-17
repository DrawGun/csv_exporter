Csv exporter
==================
This is the simple solutuon to export csv file from ```array/ActiveRecord collection```.
## Installation

Simply add into Gemfile:

```ruby
gem 'csv_exporter'
```

After that you can use ```.csv_export```  method in your own project.
```ruby
csv_export(hash_or_array_of_fields, filename)
```

Usage
------

####Scope

######Array of fields

```ruby
User.my_custom_scope.csv_export([:name, :email, :age])
User.my_custom_scope.csv_export([:name, :email, :age], 'users.csv')
```

######Hash of fields
```ruby
User.my_custom_scope.csv_export('User name' => :name, 'User email' => :emal, 'Years old' => :age)
User.my_custom_scope.csv_export({ 'User name' => :name, 'User email' => :emal, 'Years old' => :age }, 'users.csv')
```

####Array/Hash

For arrays of arrays or hashes just use ```.csv_export``` method without any parameters
```ruby
[
  ['Name', 'Age', 'Sex'],
  ['Mike', 23, 'M'],
  ['Helga', 26, 'F']
].csv_export


[
  { first: 1, second: 2, third: 3 },
  { first: 4, second: 5, third: 6 },
  { first: 'a', second: 'b', third: 'c' }
].csv_export
```
