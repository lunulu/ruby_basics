puts 'Введите длины трех сторон треугольника.'
puts 'Длина первой стороны:'
a = Float(gets.chomp)
puts 'Длина второй стороны:'
b = Float(gets.chomp)
puts 'Длина третьей стороны:'
c = Float(gets.chomp)

equilateral_triangle = true if a == b && b == c

isosceles_triangle = true if a == b || a == c || b == c

leg1, leg2, hypotenuse = [a, b, c].sort

right_triangle = true if hypotenuse**2 == leg1**2 + leg2**2

if equilateral_triangle
  puts 'Треугольник - равнобедренный и равносторонний, но не прямоугольный'
elsif isosceles_triangle && right_triangle
  puts 'Треугольник - равнобедренный и прямоугольный.'
elsif right_triangle
  puts 'Треугольник - прямоугольный.'
else
  puts 'Треугольник не является ни равнобедренным, ни равносторонним, ни прямоугольным.'
end
