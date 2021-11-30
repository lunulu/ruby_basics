puts "Введите длину основания треугольника:"
base = gets.chomp.to_f
puts "Введите длину высоты треугольника:"
height = gets.chomp.to_f

triangle_area = 0.5 * base * height

puts "Площадь треугольника: #{triangle_area}"