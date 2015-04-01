list = Array.new(20) { Object.new }

#puts "Starting count = #{ObjectSpace.each_object(Thing).count}" # 1000 objects
puts "Starting count = #{ObjectSpace.count_objects[:T_OBJECT]}"

list.each_with_index do |item, i|
  GC.start
  #GC.start(full_mark: true, immediate_sweep: true) # this doesn't matter
  puts "loop #{i} - count = #{ObjectSpace.count_objects[:T_OBJECT]}"

  item = list.shift
  # do something with the item
end

list = nil

# Ruby 2.2.1
GC.start(full_mark: true, immediate_sweep: true)

puts "Ending count = #{ObjectSpace.count_objects[:T_OBJECT]}"
#puts ObjectSpace.count_objects.inspect
