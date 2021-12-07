# frozen_string_literal: true

# Станция
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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

  # Вынес в protected, чтобы нельзя было использовать сеттеры извне объекта
  attr_writer :trains, :name
end
