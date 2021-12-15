# frozen_string_literal: true

# Пассажирский вагон
class PassengerWagon < Wagon
  def initialize
    @type = 'пассажирский'
    super
  end
end
