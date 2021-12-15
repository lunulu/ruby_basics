# frozen_string_literal: true

# Станция
class Station
  include InstanceCounter
  include ValidCheck

  attr_reader :trains, :name

  class << self
    attr_accessor :stations
  end

  self.stations = []

  def self.all
    stations
    # Второй вариант
    # ObjectSpace.each_object(self).to_a
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

  # Решил разделить проверки, так как не смог исправить ошибку уникальности через .valid?
  def init_validate!
    validate!
    raise 'The name must be unique' if self.class.stations.select { |st| st.name == name }.size == 1
  end

  def validate!
    raise 'The name must contain letters or numbers' if name.gsub(/\s+/, '') == ''
  end
end
