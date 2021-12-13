# frozen_string_literal: true

# Пассажирский поезд
class PassengerTrain < Train
  def initialize(number)
    @type = 'пассажирский'
    super
  end
end
