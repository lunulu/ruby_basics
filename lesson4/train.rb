# frozen_string_literal: true

# Поезд
class Train
  attr_reader :speed, :carriages_number, :type

  def initialize(number, type, carriages_number)
    @number = number
    @type = type.include?('грузовой') || type.include?('пассажирский') ? type : 'грузовой'
    @carriages_number = carriages_number
    @speed = 0
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def attach_carriage
    @carriages_number += 1 if @speed.zero?
  end

  def detach_carriage
    @carriages_number -= 1 if @speed.zero? && @carriages_number.positive?
  end

  def add_route(route)
    @route = route
    @current_position = 0
    @route.stations[@current_position].take_train(self)
  end

  def move_forward
    @route.stations[@current_position].send_train(self)
    @current_position += 1 if @route.stations[@current_position] != @route.end_station
    @route.stations[@current_position].take_train(self)
  end

  def move_backward
    @route.stations[@current_position].send_train(self)
    @current_position -= 1 if @current_station.positive?
    @route.stations[@current_position].take_train(self)
  end

  def current_station
    @route.stations[@current_position]
  end

  def previous_station
    @route.stations[@current_position - 1] if @current_position.positive?
  end

  def next_station
    @route.stations[@current_position + 1] if @route.stations[@current_position] != @route.end_station
  end
end
