# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

# Железная дорога
class RailRoad
  attr_reader :stations, :routes, :trains

  def seed
    self.stations = create_stations
    self.routes = create_routes(stations)
    self.trains = create_trains
    [stations, routes, trains]
  end

  def app
    puts 'Добро пожаловать в программу управления железнодорожными сетями.'
    puts 'Здесь можно создавать станции, маршруты и поезда.'
    loop do
      info
      case gets.chomp
      when '1' then stations_app
      when '2' then routes_app
      when '3' then trains_app
      when '4' then control_app
      when 'exit' then break
      else
        puts 'Неверный ввод.'
        sleep 1
        system 'clear'
      end
    end
  end

  private

  attr_writer :stations, :routes, :trains

  def stations_app
    # Добавление станций
  end

  def routes_app
    # Создание маршрутов
    # Добавление станций
    # Удаление станций
  end

  def trains_app
    # Создание поездов
    # Добавление вагонов к поезду
    # Отцеплять вагоны от поезда
    # Назначить маршрут поезду
  end

  def control_app
    # Перемещать поезд по маршруту вперед и назад
    # Просматривать список станций и список поездов на станции
  end

  def info
    puts 'Наберите на клавитуре и нажмите Enter, чтобы выбрать действие:'
    puts 'С чем вы хотите работать?'
    puts '1 - Станции'
    puts '2 - Маршруты'
    puts '3 - Поезда'
    puts '4 - Управление движением'
    puts 'exit - Выйти из программы'
  end

  def create_stations
    stations = []
    stations << Station.new('Москва')
    stations << Station.new('Санкт-Петербург')
    stations << Station.new('Новосибирск')
    stations << Station.new('Екатеринбург')
    stations << Station.new('Казань')
    stations << Station.new('Нижний Новгород')
    stations << Station.new('Челябинск')
    stations << Station.new('Омск')
  end

  def create_routes(stations)
    routes = []
    routes << Route.new(stations[0], stations[4])
    routes << Route.new(stations[1], stations[5])
    routes << Route.new(stations[2], stations[6])
    routes << Route.new(stations[3], stations[7])
    add_way_stations!(routes)
    routes
  end

  def add_way_stations!(routes)
    routes[1].add_way_station(stations[1])
    routes[2].add_way_station(stations[2])
    routes[2].add_way_station(stations[4])
    routes[3].add_way_station(stations[3])
    routes[3].add_way_station(stations[4])
    routes[3].add_way_station(stations[5])
  end

  def create_trains
    trains = []
    passenger_train = PassengerTrain.new(1)
    cargo_train = CargoTrain.new(2)
    3.times { passenger_train.attach_wagon(PassengerWagon.new) }
    10.times { cargo_train.attach_wagon(CargoWagon.new) }
    trains.push(passenger_train, cargo_train)
  end
end
