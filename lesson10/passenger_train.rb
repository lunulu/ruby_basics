# frozen_string_literal: true

# Passenger Train
class PassengerTrain < Train
  def initialize(number)
    @type = 'пассажирский'
    super
  end
end
