require 'wrapper'

data = Array.new(100) { "x" * 1024 * 1024 }

measure do
  data.map! { |str| str.upcase! }
end
