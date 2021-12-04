# frozen_string_literal: true

# Станция
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_types
    passenger_trains_number = trains.select { |train| train.type == 'пассажирский' }.sum
    freight_trains_number = trains.select { |train| train.type == 'грузовой' }.sum
    { 'пассажирский' => passenger_trains_number, 'грузовой' => freight_trains_number }
  end
end
