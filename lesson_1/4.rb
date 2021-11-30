puts "Введите коэффициенты a,b и c"
puts "Коэффициент a:"
a = gets.chomp.to_f
puts "Коэффициент b"
b = gets.chomp.to_f
puts "Коэффициент c:"
c = gets.chomp.to_f

discriminant = b ** 2 - 4 * a * c

if discriminant > 0
  x1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Дискриминант равен #{discriminant}, корни: #{x1} и #{x2}."
elsif discriminant == 0
  x = -b / (2 * a)
  puts "Дискриминант равен #{discriminant}, единственный корень: #{x}."
else
  puts "Дискриминант равен #{discriminant}, корней нет."
end