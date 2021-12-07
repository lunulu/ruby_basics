# frozen_string_literal: true

# Пассажирский вагон
class PassengerWagon < Wagon
  def initialize
    super
    @type = 'пассажирский'
  end
end
