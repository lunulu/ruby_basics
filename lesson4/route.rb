# frozen_string_literal: true

# Маршрут
class Route
  attr_reader :stations

  def initialize(starting_station, end_station)
    @stations = [starting_station, end_station]
  end

  def add_way_station(station)
    @stations.insert(1, station)
  end

  def delete_way_station(station)
    @stations.delete(station) if station != stations.first || stations.last
  end

  def show_route_stations
    stations.each { |station| puts station }
  end

  def starting_station
    stations.first
  end

  def end_station
    stations.last
  end
end
