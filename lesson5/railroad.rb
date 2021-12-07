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

  def app
    puts 'Добро пожаловать в программу управления железнодорожными сетями.'
    self.stations = []
    self.routes = []
    self.trains = []
    loop do
      info
      case gets.chomp
      when '1' then stations_app
      when '2' then routes_app
      when '3' then trains_app
      when '4' then control_app
      when 'seed' then seed
      when 'выход' then break
      else
        puts 'Неверный ввод.'
        sleep 1
        system 'clear'
      end
    end
  end

  private

  attr_writer :stations, :routes, :trains

  # Внутренние части приложения, которые должны быть доступны только внутри класса
  def stations_app
    puts 'Здесь можно создавать станции'
    puts 'Введите название станции и нажмите Enter, чтобы добавить станцию'
    puts '\'станции\', чтобы получить список добавленных станций'
    puts '\'назад\', чтобы вернуться в главное меню'
    loop do
      input = gets.chomp.downcase
      case input
      when 'назад' then break
      when 'выход' then break
      when 'станции' then stations.each { |station| puts station.name }
      else stations << Station.new(input.capitalize)
      end
    end
  end

  def routes_app
    puts 'Здесь можно создавать маршруты, добавлять и удалять промежуточные станции'
    puts '1 - Добавить новый маршрут'
    puts '2 - Добавить станцию в существующий маршрут'
    puts '3 - Удалить станцию из существующего маршрута'
    puts '\'маршруты\' - Отобразить существующие маршруты'
    puts '\'назад\', чтобы вернуться в главное меню'
    loop do
      input = gets.chomp.downcase
      case input
      when 'назад' then break
      when 'выход' then break
      when 'маршруты' then routes.each { |route| puts "#{route.starting_station.name} - #{route.end_station.name}" }
      when '1'
        puts 'Список существующих станций:\n'
        stations.each { |station| puts station.name }
        puts 'Введите название начальной станции:'
        station1 = stations.select { |station| station.name == gets.chomp.capitalize }.first
        puts 'Введите название конечной станции:'
        station2 = stations.select { |station| station.name == gets.chomp.capitalize }.first
        routes << Route.new(station1, station2)
        puts "Маршрут #{routes.last.starting_station.name} - #{routes.last.end_station.name} добавлен."
      when '2'
        puts 'Список существующих станций:'
        stations.each { |station| puts station.name }
        puts 'Выберите маршрут, в который хотите добавить промежуточную станцию:'
        i = 1
        routes.each do |route|
          puts "#{i}: #{route.starting_station.name} - #{route.end_station.name}"
          i += 1
        end
        route_number = gets.chomp.to_i
        puts 'Введите название промежуточной станции:'
        way_station = stations.select { |station| station.name == gets.chomp.capitalize }.first
        routes[route_number - 1].add_way_station(way_station)
        puts "Промежуточная станция #{way_station} добавлена"
      when '3'
        puts 'Выберите маршрут, в который хотите удалить промежуточную станцию:'
        i = 1
        routes.each do |route|
          puts "#{i}: #{route.starting_station.name} - #{route.end_station.name}"
          i += 1
        end
        route_number = gets.chomp.to_i - 1
        puts 'Список промежуточных станций этого маршрута:'
        route = routes[route_number]
        route.stations.pop
        route.stations.shift
        route.show_route_stations
        puts 'Выберите станцию, которую хотите удалить:'
        route.delete_way_station(gets.chomp.capitalize)
        puts 'Промежуточная станция удалена'
      else puts 'Неверный ввод.'
      end
    end
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
    puts '1 - Станции'
    puts '2 - Маршруты'
    puts '3 - Поезда'
    puts '4 - Управление движением'
    puts 'выход - Выйти из программы'
  end

  # Автоматически создает станции, маршруты и поезда
  def seed
    self.stations = create_stations
    self.routes = create_routes(stations)
    self.trains = create_trains
    system 'clear'
    puts 'Seed успешно активирован.'
    sleep 3
    system 'clear'
    [stations, routes, trains]
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
