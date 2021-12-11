# frozen_string_literal: true

# Поезд
class Train
  include CompanyManufacturerInfo
  include InstanceCounter

  attr_reader :speed, :wagons, :type, :route, :current_position, :number

  self.counter = 0

  def self.find(number)
    ObjectSpace.each_object(self).to_a.select { |train| train.number == number }.first
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    register_instance
  end

  def accelerate(speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def attach_wagon(wagon)
    wagons << wagon if type == wagon.type
  end

  def detach_wagon
    wagons.pop
  end

  def add_route(route)
    self.route = route
    self.current_position = 0
    current_station.take_train(self)
  end

  def move_forward
    current_station.send_train(self)
    self.current_position += 1 if next_station
    current_station.take_train(self)
  end

  def move_backward
    current_station.send_train(self)
    self.current_position -= 1 if previous_station
    current_station.take_train(self)
  end

  def current_station
    route.stations[current_position]
  end

  def previous_station
    route.stations[current_position - 1] if current_position.positive?
  end

  def next_station
    route.stations[current_position + 1] if current_station != route.end_station
  end

  protected

  # Вынес в protected, чтобы нельзя было использовать сеттеры извне объекта
  attr_writer :speed, :wagons, :type, :route, :current_position
end
