# frozen_string_literal: true

# Пока проверять на валидность правильно не умею
puts 'День?'
day = gets.to_i
puts 'Месяц?'
month = gets.to_i
puts 'Год?'
year = gets.to_i

days_in_february = (year % 4).zero? ? 29 : 28
day_number = [31, days_in_february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].take(month - 1).sum + day
puts "Прошло #{day_number} дней с начала года."
