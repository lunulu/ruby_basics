puts "Введите длины трех сторон треугольника."
puts "Длина первой стороны:"
a = gets.chomp.to_f
puts "Длина второй стороны:"
b = gets.chomp.to_f
puts "Длина третьей стороны:"
c = gets.chomp.to_f

if (a == b && b == c)
  equilateral_triangle = true
end
if a == b || a == c || b == c
  isosceles_triangle = true
end

if a > b && a > c
  hypotenuse = a
  leg_1 = b
  leg_2 = c
elsif b > a && b > c
  hypotenuse = b
  leg_1 = a
  leg_2 = c
elsif c > a && c > b
  hypotenuse = c
  leg_1 = a
  leg_2 = b
end

if hypotenuse != nil && hypotenuse ** 2 == leg_1 ** 2 + leg_2 ** 2
  right_triangle = true
end

if equilateral_triangle
  puts "Треугольник - равнобедренный и равносторонний, но не прямоугольный"
elsif isosceles_triangle && right_triangle
  puts "Треугольник - равнобедренный и прямоугольный."
elsif right_triangle
  puts "Треугольник - прямоугольный."
else
  puts "Треугольник не является ни равнобедренным, ни равносторонним, ни прямоугольным."
end