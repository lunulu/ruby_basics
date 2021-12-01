puts 'Введите длину основания треугольника:'
base = Float(gets.chomp)
puts 'Введите длину высоты треугольника:'
height = Float(gets.chomp)

triangle_area = 0.5 * base * height

puts "Площадь треугольника: #{triangle_area}"
