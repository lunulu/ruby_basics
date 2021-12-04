# frozen_string_literal: true

puts 'Високосный год?'
puts 'Да или нет:'
days_in_february = String(gets.chomp).downcase == 'да' ? 29 : 28

months = {  'Январь' => 31, 'Февраль' => days_in_february, 'Март' => 31, 'Апрель' => 30, 'Май' => 31, 'Июнь' => 30,
            'Июль' => 31, 'Август' => 31, 'Сентябрь' => 30, 'Октябрь' => 31, 'Ноябрь' => 30, 'Декабрь' => 31 }

months.each do |month, days|
  puts month if days == 30
end
