class Thing; end
list = Array.new(20) { Thing.new }

puts "Starting count = #{ObjectSpace.each_object(Thing).count}" # 1000 objects

list.each_with_index do |item, i|
  #GC.start
  GC.start(full_mark: true, immediate_sweep: true) # this doesn't matter
  puts "loop #{i} - count = #{ObjectSpace.each_object(Thing).count}"

  # do something with the item
end

list = nil

# Ruby 2.2.1
GC.start(full_mark: true, immediate_sweep: true)

puts "Ending count = #{ObjectSpace.each_object(Thing).count}" # 1000 objects
