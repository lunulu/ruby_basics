# frozen_string_literal: true

# Пока проверять на валидность правильно не умею
puts 'День?'
day = Integer(gets)
puts 'Месяц?'
month = Integer(gets)
puts 'Год?'
year = Integer(gets)

days_in_february = (year % 4).zero? ? 29 : 28

months = {  1 => 31, 2 => days_in_february, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
            7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

day_number = day
months.each do |k, v|
  break if k == month

  day_number += v
end
puts "Прошло #{day_number} дней с начала года."
