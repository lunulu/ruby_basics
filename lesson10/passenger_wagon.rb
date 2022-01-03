# frozen_string_literal: true

# Passenger Wagon
class PassengerWagon < Wagon
  attr_reader :number_of_seats, :seats_occupied

  def initialize(number_of_seats)
    @type = 'пассажирский'
    @number_of_seats = number_of_seats
    @seats_occupied = 0
    super()
  end

  def take_a_seat
    self.seats_occupied += 1 if seats_occupied < number_of_seats
  end

  def free_seats
    number_of_seats - seats_occupied
  end

  protected

  attr_writer :number_of_seats, :seats_occupied

  def validate!
    super
    raise 'The number of seats cannot be negative' if number_of_seats.negative?
  end
end
