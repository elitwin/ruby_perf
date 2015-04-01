require 'date'
require 'rubygems'
require 'ruby-prof'

GC.disable

result = RubyProf.profile do
  Date.parse("2015-04-01")
end

printer = RubyProf::FlatPrinter.new(result)
puts printer.print
#printer.print(File.open("zapp_flat_profile.txt", "w+"), min_percent: 3)
