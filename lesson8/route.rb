# frozen_string_literal: true

# Маршрут
class Route
  include InstanceCounter
  include ValidCheck

  attr_reader :stations, :station_pool

  def initialize(name1, name2, station_pool)
    @station_pool = station_pool
    station1 = station_select(name1)
    station2 = station_select(name2)
    self.stations = [station1, station2]
    validate!
    register_instance
  end

  def add_way_station(name)
    stations.insert(-2, station_select(name))
  end

  def delete_way_station(name)
    stations.delete(station_select(name)) if name != stations.first.name && name != stations.last.name
  end

  def starting_station
    stations.first
  end

  def end_station
    stations.last
  end

  protected

  attr_writer :stations, :station_pool

  def station_select(name)
    station_pool.select { |st| st.name == name }.first
  end

  # def station_exists?(name)
  #   !station_select(name).nil?
  # end

  def validate!
    raise 'The route must have at least 2 stations' if stations.length < 2
  end
end
