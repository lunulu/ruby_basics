puts "Введите ваше имя:"
name = gets.chomp
puts "Введите ваш рост:"
height = gets.chomp

perfect_weight = (height.to_f - 110) * 1.15

if perfect_weight < 0
  puts "Ваш вес уже оптимальный."
else
  puts "#{name}, ваш идеальный вес - #{perfect_weight} килограмм."
end