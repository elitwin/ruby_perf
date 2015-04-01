require 'wrapper'

str = "X" * 1024 * 1024 * 10 # 10M string
measure do
  # same as str = str + 'Z' - extra memory needed to result of concatenation
  str + 'Z'
end

measure do
  str << 'Z'
end
