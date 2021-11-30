puts "Введите длину основания треугольника:"
base = gets.chomp
puts "Введите длину высоты треугольника:"
height = gets.chomp

triangle_area = 0.5 * base.to_f * height.to_f

puts "Площадь треугольника: #{triangle_area}"