# frozen_string_literal: true

# Пассажирский поезд
class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'пассажирский'
  end
end
