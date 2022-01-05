# frozen_string_literal: true

# Station
class Station
  include InstanceCounter
  include Validation

  FORMAT = /^[а-я]{2,20}$/i.freeze
  TYPE = String

  attr_reader :trains, :name

  class << self
    attr_writer :stations

    def stations
      @stations ||= []
    end

    def all
      stations
    end
  end

  def initialize(name)
    @name = name.capitalize
    @trains = []
    init_validate!
    self.class.stations << self
    register_instance
  end

  def iterator(&block)
    return unless block_given?

    trains.each { |train| block.call(train) }
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_types
    trains_list = trains.map(&:class)
    { 'пассажирский' => trains_list.count(PassengerTrain), 'грузовой' => trains_list.count(CargoTrain) }
  end

  protected

  attr_writer :trains, :name

  def init_validate!
    validate!
    raise 'The name must be unique' if self.class.stations.map(&:name).include?(name)
  end
end
