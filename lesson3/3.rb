# frozen_string_literal: true

array = [1, 1]
# Не знаю как тут ограничить ровно на 100
array.push(array[array.size - 1] + array[array.size - 2]) while array.last < 89
puts array
