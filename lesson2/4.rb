# frozen_string_literal: true

puts 'Введите коэффициенты a,b и c'
puts 'Коэффициент a:'
a = Float(gets.chomp)
puts 'Коэффициент b'
b = Float(gets.chomp)
puts 'Коэффициент c:'
c = Float(gets.chomp)

discriminant = (b**2) - (4 * a * c)

if discriminant.positive?
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Дискриминант равен #{discriminant}, корни: #{x1} и #{x2}."
elsif discriminant.zero?
  x = -b / (2 * a)
  puts "Дискриминант равен #{discriminant}, единственный корень: #{x}."
else
  puts "Дискриминант равен #{discriminant}, корней нет."
end
