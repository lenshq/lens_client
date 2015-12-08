require_relative('lens_memprof')
include LensCMemprof
puts allocations
puts "=" * 100
puts "#{allocations} = 0"

a = 1
puts "#{allocations} = 0"
class A
end
puts "#{allocations} = 0"

start
puts "#{allocations} = 0"

puts "-" * 100
a = A.new
puts "#{allocations} = 1"

puts '-' * 100
b = A.new
puts "#{allocations} = 1"

reset
puts "#{allocations} = 0"
puts '-' * 100

c = 10.times.map { A.new }
puts "#{allocations} = 10"

puts '-' * 100

puts "#{allocations} = 10"
print allocations
print allocations
print allocations
puts allocations
puts allocations
puts allocations
puts "#{allocations} = 10"
puts "#{allocations} = 10"
puts "#{allocations} = 10"
puts "#{allocations} = 10"
puts "#{allocations} = 10"
stop
