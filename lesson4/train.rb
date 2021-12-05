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
    current_station.take_train(self)
  end

  def move_forward
    current_station.send_train(self)
    @current_position += 1 if next_station
    current_station.take_train(self)
  end

  def move_backward
    current_station.send_train(self)
    @current_position -= 1 if previous_station
    previous_station.take_train(self)
  end

  def current_station
    @route.stations[@current_position]
  end

  def previous_station
    @route.stations[@current_position - 1] if @current_position.positive?
  end

  def next_station
    @route.stations[@current_position + 1] if current_station != @route.end_station
  end
end
