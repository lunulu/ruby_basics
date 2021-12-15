# frozen_string_literal: true

# Станция
class Station
  include InstanceCounter
  include ValidCheck

  attr_reader :trains, :name

  class << self
    attr_writer :stations

    def stations
      @stations ||= []
    end

    def all
      stations
    end

    def iterator(&block)
      return unless block_given?

      trains.each { |train| block.call(train) }
    end
  end

  def initialize(name)
    @name = name.capitalize
    @trains = []
    init_validate!
    self.class.stations << self
    register_instance
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_types
    passenger_trains_number = trains.select { |train| train.is_a? PassengerTrain }.sum
    freight_trains_number = trains.select { |train| train.is_a? CargoTrain }.sum
    { 'пассажирский' => passenger_trains_number, 'грузовой' => freight_trains_number }
  end

  protected

  attr_writer :trains, :name

  def init_validate!
    validate!
    raise 'The name must be unique' if self.class.stations.map(&:name).include?(name)
  end

  def validate!
    raise 'The name must contain letters or numbers' if name.gsub(/\s+/, '') == ''
  end
end
