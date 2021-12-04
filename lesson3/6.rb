# frozen_string_literal: true

cart = {}

loop do
  puts 'Введите название товара или напишите \'стоп\':'
  product_name = gets.chomp

  break if product_name == 'стоп'

  puts 'Введите цену за единицу товара:'
  price = Float(gets.chomp)
  puts 'Введите количество товара:'
  product_quantity = Float(gets.chomp)

  cart[product_name] = { price: price, product_quantity: product_quantity }
end

puts cart

sum = 0
cart.each do |k, v|
  each_product_total_price = v[:price] * v[:product_quantity]
  puts "Сумма за #{k} равна #{each_product_total_price}."
  sum += each_product_total_price
end
puts "Сумма всех покупок: #{sum}."
