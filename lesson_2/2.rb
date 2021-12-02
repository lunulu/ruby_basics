# frozen_string_literal: true

array = (10..100).map { |i| i if (i % 5).zero? }.compact
puts array
