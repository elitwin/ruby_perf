require 'wrapper'

str = "X" * 1024 * 1024 * 10 # 10M string
measure do
  # allocates 10M in memory to copy the string
  str = str.downcase
end

measure do
  str.downcase!
end
