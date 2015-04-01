require 'date'
require 'rubygems'
require 'ruby-prof'

# This generates CSV like
# 1, John McTest, 1980-07-01
# 2, Peter McGregor, 1985-12-23
# 3, Sylvia McIntosh, 1989-06-13
def generate_test_data
  50000.times.map do |i|
    name = ["John", "Peter", "Sylvia"][rand(3)] + " " +
      ["McTest", "McGregor", "McIntosh"][rand(3)]
    [i, name, Time.at(rand * Time.now.to_i).strftime("%Y-%m-%d") ].join(',')
  end.join("\n")
end

def parse_data(data)
  data.split("\n").map! { |row| parse_row(row) }
end

def parse_row(row)
  row.split(",").map! { |col| parse_col(col) }
end

def parse_col(col)
  if col =~ /^\d+$/
    col.to_i
  elsif col =~ /^\d{4}-\d{2}-\d{2}$/
    Date.parse(col)
  else
    col
  end
end

def find_youngest(people)
  people.map! { |person| person[2] }.max
end

data = generate_test_data

GC.disable

result = RubyProf.profile do
  people = parse_data(data)
  find_youngest(people)
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("app_flat_profile.txt", "w+"), min_percent: 3)
printer = RubyProf::GraphPrinter.new(result)
printer.print(File.open("app_graph_profile.txt", "w+"), min_percent: 3)
printer = RubyProf::CallStackPrinter.new(result)
printer.print(File.open("app_call_stack_profile.html", "w+"))
