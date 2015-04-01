require 'benchmark'

num_rows = 100000
num_cols = 10

gc = ARGV[0] == '--no-gc' ? 'Disabled' : 'Enabled'
puts "Benchmarking Ruby #{RUBY_VERSION} - GC #{gc}"

GC.disable if ARGV[0] == '--no-gc'
data = []

time = Benchmark.realtime do
  data = Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } }
end

# rss is resident set size - rss= tells ps not to return a header
puts "Create Time = #{time.round(2)}"
if ARGV[1] == '--mem'
  mem = "%dM" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
  puts "Create Memory = #{mem}"
end

csv = ''
time = Benchmark.realtime do
  num_rows.times do |i|
    num_cols.times do |j|
      csv << data[i][j]
      csv << "," unless j == num_cols - 1
    end
    csv << "\n" unless i = num_rows - 1
  end
end

puts "Concat Time = #{time.round(2)}"
if ARGV[1] == '--mem'
  mem = "%dM" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
  puts "Concat Memory = #{mem}"
end
