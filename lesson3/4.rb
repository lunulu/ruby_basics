# frozen_string_literal: true

# Как можно сделать это лучше?
hash = Hash[%w[a e i o u].collect { |item| [item, item.bytes[0] - 96] }]
puts hash
