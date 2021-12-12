# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'company_manufacturer_info'
require_relative 'station'
require_relative 'route'
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
    system 'clear'
    puts 'Программа для управления железной дорогой.'
    self.stations = []
    self.routes = []
    self.trains = []
    sleep 1.5
    loop do
      system 'clear'
      puts 'Наберите на клавитуре и нажмите Enter, чтобы выбрать действие:'
      puts '1 - Создать станцию'
      puts '2 - Создать маршрут'
      puts '3 - Создать поезд'
      puts '4 - Добавить станцию в маршрут'
      puts '5 - Удалить станцию из маршрута'
      puts '6 - Назначить маршрут поезду'
      puts '7 - Добавить вагоны к поезду'
      puts '8 - Отцепить вагоны от поезда'
      puts '9 - Перемещать поезд'
      puts '10 - Список станций'
      puts '11 - Список маршрутов'
      puts '12 - Список поездов'
      puts '0 - Выйти из программы'
      case gets.chomp
      when '1' then add_station_app
      when '2' then add_route_app
      when '3' then add_train_app
      when '4' then add_way_station_app
      when '5' then delete_way_station_app
      when '6' then set_route_app
      when '7' then attach_cargo_app
      when '8' then detach_cargo_app
      when '9' then move_train_app
      when '10' then stations_list_app
      when '11' then routes_list_app
      when '12' then trains_list_app
      when '0' then break
      when 'seed' then seed
      else
        puts 'Неверный ввод.'
        sleep 1
      end
      system 'clear'
    end
    system 'clear'
  end

  private

  attr_writer :stations, :routes, :trains

  # Внутренние части приложения, которые должны быть доступны только внутри класса
  def add_station_app
    system 'clear'
    puts 'Введите название станции и нажмите Enter, чтобы добавить станцию'
    station = gets.chomp.capitalize
    return if station.gsub(/\s+/, '') == ''
    return if stations.select { |st| st.name == station }.first

    stations << Station.new(station)
  end

  def station_select
    stations.select { |station| station.name == gets.chomp.capitalize }.first
  end

  def add_route_app
    system 'clear'
    puts 'Введите название начальной станции:'
    station1 = station_select
    puts 'Введите название конечной станции:'
    station2 = station_select
    routes << Route.new(station1, station2)
  end

  def add_train_app
    system 'clear'
    puts 'Номер поезда:'
    number = gets.chomp.to_i
    puts 'Тип поезда (пассажирский или грузовой):'
    trains << gets.chomp.downcase == 'пассажирский' ? PassengerTrain.new(number) : CargoTrain.new(number)
  end

  def show_all_routes_stations_list
    system 'clear'
    i = 1
    routes.each do |route|
      print "#{i} "
      route.show_route_stations
      i += 1
    end
  end

  def add_way_station_app
    system 'clear'
    puts 'Выберите маршрут, в который хотите добавить промежуточную станцию:'
    show_all_routes_stations_list
    route_number = gets.chomp.to_i - 1
    puts 'Введите название промежуточной станции:'
    way_station = station_select
    routes[route_number].add_way_station(way_station)
  end

  def delete_way_station_app
    system 'clear'
    puts 'Выберите маршрут, в котором хотите удалить промежуточную станцию:'
    show_all_routes_stations_list
    route_number = gets.chomp.to_i - 1
    puts 'Выберите станцию, которую хотите удалить:'
    routes[route_number].delete_way_station(gets.chomp.capitalize)
  end

  def show_all_trains
    system 'clear'
    i = 1
    trains.each do |train|
      puts "#{i}: №#{train.number}, #{train.type}"
      i += 1
    end
  end

  def set_route_app
    system 'clear'
    puts 'Выберите поезд, которому хотите задать маршрут:'
    show_all_trains
    train_number = gets.chomp.to_i - 1
    puts 'Выберите маршрут:'
    show_all_routes_stations_list
    route_number = gets.chomp.to_i - 1
    trains[train_number].add_route(routes[route_number])
  end

  def attach_cargo_app
    system 'clear'
    show_all_trains
    train_number = gets.chomp.to_i - 1
    puts 'Сколько вагонов добавить?'
    quantity = gets.chomp.to_i
    if trains[train_number].type == 'пассажирский'
      quantity.times { trains[train_number].attach_wagon(PassengerWagon.new) }
    else
      quantity.times { trains[train_number].attach_wagon(CargoWagon.new) }
    end
  end

  def detach_cargo_app
    system 'clear'
    show_all_trains
    train_number = gets.chomp.to_i - 1
    puts 'Сколько вагонов отцепить?'
    quantity = gets.chomp.to_i
    if trains[train_number].type == 'пассажирский'
      quantity.times { trains[train_number].detach_wagon(PassengerWagon.new) }
    else
      quantity.times { trains[train_number].detach_wagon(CargoWagon.new) }
    end
  end

  def move_train_app
    system 'clear'
    puts 'Выберите поезд, который хотите перемещать:'
    show_all_trains
    train_number = gets.chomp.to_i - 1
    puts '1 - двигаться вперед'
    puts '2 - двигаться назад'
    case gets.chomp
    when '1' then trains[train_number].move_forward
    when '2' then trains[train_number].move_backward
    end
  end

  def waiting_mode
    puts
    puts 'Нажмите Enter, чтобы закрыть'
    gets.chomp.to_i
  end

  def stations_list_app
    system 'clear'
    stations.each do |station|
      print "#{station.name}, Поезда:"
      station.trains.each { |train| print " №#{train.number}" }
      puts
    end
    waiting_mode
  end

  def routes_list_app
    system 'clear'
    show_all_routes_stations_list
    waiting_mode
  end

  def trains_list_app
    system 'clear'
    show_all_trains
    waiting_mode
  end

  # Автоматически создает станции, маршруты и поезда
  def seed
    self.stations = create_stations
    self.routes = create_routes(stations)
    self.trains = create_trains
    system 'clear'
    puts 'Seed успешно активирован.'
    sleep 1.5
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
    4.times { |i| routes << Route.new(stations[i], stations[i + 4]) }
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
    passenger_train.add_route(routes[1])
    cargo_train.add_route(routes[1])
  end
end
