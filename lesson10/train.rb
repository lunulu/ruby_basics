# frozen_string_literal: true

# Train
class Train
  include CompanyManufacturerInfo
  include InstanceCounter
  include ValidCheck

  NUMBER_FORMAT = /^[а-я0-9]{3}-?[а-я0-9]{2}$/i.freeze

  attr_reader :speed, :wagons, :type, :route, :current_position, :number

  @@trains = []

  def self.find(number)
    @@trains.detect { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains << self
    register_instance
  end

  def iterator(&block)
    return unless block_given?

    wagons.each { |wagon| block.call(wagon) }
  end

  def accelerate(speed)
    self.speed = speed
  end

  def brake
    self.speed = 0
  end

  def select_wagon(number)
    wagons.detect { |wagon| wagon.number == number }
  end

  def attach_wagon(wagon)
    wagons << wagon if type == wagon.type
  end

  def detach_wagon(number)
    wagons.delete_at(wagons.map(&:number).index(number))
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

  attr_writer :speed, :wagons, :type, :route, :current_position

  def validate!
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    raise 'Number must be unique' if @@trains.map(&:number).include?(number)
    raise 'Type has invalid format' if type != 'пассажирский' && type != 'грузовой'
  end
end
