# frozen_string_literal: true

# Пассажирский вагон
class PassengerWagon < Wagon
  def initialize
    super # Добавил super, потому что rubocop ругался
    @type = 'пассажирский'
  end
end
