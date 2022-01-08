# frozen_string_literal: true

# Passenger Train
class PassengerTrain < Train
  validate :number, :format, /^[а-я0-9]{3}-?[а-я0-9]{2}$/i

  def initialize(number)
    @type = 'пассажирский'
    super
  end
end
