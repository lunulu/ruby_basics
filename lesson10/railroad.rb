# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'
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

# Railroad
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
      options_message
      option = gets.chomp
      system 'clear'
      case option
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
      when '13' then occupy_wagon_app
      when '0' then break
      when 'seed' then seed
      else
        puts 'Неверный ввод.'
        sleep 1
      end
      system 'clear'
    end
  end

  private

  attr_writer :stations, :routes, :trains

  # -------------------------------------------------------------

  # 1
  def add_station_app
    puts 'Введите название станции и нажмите Enter, чтобы добавить станцию'
    stations << Station.new(gets.chomp.capitalize)
  end

  # 2
  def add_route_app
    show_all_stations
    puts 'Введите название начальной станции:'
    station1 = gets.chomp.capitalize
    puts 'Введите название конечной станции:'
    station2 = gets.chomp.capitalize
    routes << Route.new(station1, station2, stations)
  end

  # 3
  def add_train_app
    puts 'Номер поезда:'
    number = gets.chomp
    puts 'Тип поезда:'
    puts '1 - пассажирский'
    puts '2 - грузовой'
    case gets.chomp.to_i
    when 1 then trains << PassengerTrain.new(number)
    when 2 then trains << CargoTrain.new(number)
    end
    puts "Поезд №#{number} создан. Тип: #{trains.last.type}"
    sleep 1.5
  rescue RuntimeError
    system 'clear'
    puts 'Неверный формат номера поезда'
    retry
  end

  # 4
  def add_way_station_app
    puts 'Выберите маршрут, в который хотите добавить промежуточную станцию:'
    show_all_routes
    route_number = gets.chomp.to_i - 1
    puts 'Введите название промежуточной станции:'
    way_station = gets.chomp.capitalize
    routes[route_number].add_way_station(way_station)
  end

  # 5
  def delete_way_station_app
    puts 'Выберите маршрут, в котором хотите удалить промежуточную станцию:'
    show_all_routes
    route_number = gets.chomp.to_i - 1
    puts 'Выберите станцию, которую хотите удалить:'
    routes[route_number].delete_way_station(gets.chomp.capitalize)
  end

  # 6
  def set_route_app
    puts 'Выберите поезд, которому хотите задать маршрут:'
    show_all_trains
    train_number = gets.chomp.to_i - 1
    system 'clear'
    puts 'Выберите маршрут:'
    show_all_routes
    route_number = gets.chomp.to_i - 1
    trains[train_number].add_route(routes[route_number])
  end

  # 7
  def attach_cargo_app
    show_all_trains
    train_number = gets.chomp.to_i - 1
    puts 'Количество мест или общий объем вагона:'
    quantity = gets.chomp.to_i
    if trains[train_number].type == 'пассажирский'
      trains[train_number].attach_wagon(PassengerWagon.new(quantity))
    else
      trains[train_number].attach_wagon(CargoWagon.new(quantity))
    end
  end

  # 8
  def detach_cargo_app
    show_all_trains
    puts 'Номер поезда:'
    train_number = gets.chomp.to_i - 1
    puts 'Номер вагона:'
    wagon_number = gets.chomp.to_i
    trains[train_number].detach_wagon(wagon_number)
  end

  # 9
  def move_train_app
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

  # 10
  def stations_list_app
    show_all_stations
    waiting_mode
  end

  # 11
  def routes_list_app
    show_all_routes
    waiting_mode
  end

  # 12
  def trains_list_app
    show_all_trains
    waiting_mode
  end

  # 13
  def occupy_wagon_app
    show_all_trains
    puts 'Номер поезда:'
    train_number = gets.chomp.to_i - 1
    puts 'Номер вагона:'
    wagon_number = gets.chomp.to_i
    puts 'Количество занимаемых мест/объема:'
    quantity = gets.chomp.to_i
    if trains[train_number].type == 'пассажирский'
      quantity.times { trains[train_number].select_wagon(wagon_number).take_a_seat }
    else
      trains[train_number].select_wagon(wagon_number).occupy_volume(quantity)
    end
  end

  # -------------------------------------------------------------

  def show_all_routes
    i = 1
    routes.each do |route|
      print "#{i} "
      route.stations.each { |station| print "- #{station.name} " }
      puts
      i += 1
    end
  end

  def show_all_trains
    i = 1
    trains.each do |train|
      puts "#{i}: №#{train.number}, #{train.type}, вагоны:"
      if train.type == 'пассажирский'
        train.iterator do |wagon|
          puts "\t№#{wagon.number}, тип: #{wagon.type}, свободно мест: #{wagon.free_seats}, занято мест: #{wagon.seats_occupied}"
        end
      else
        train.iterator do |wagon|
          puts "\t№#{wagon.number}, тип: #{wagon.type}, свободно объема: #{wagon.free_volume}, занято объема: #{wagon.volume_occupied}"
        end
      end
      i += 1
    end
  end

  def show_all_stations
    stations.each do |station|
      puts "#{station.name}, поезда:"
      station.iterator { |train| puts "\t№#{train.number}, #{train.type}, вагонов: #{train.wagons.length};" }
    end
  end

  def waiting_mode
    puts
    puts 'Нажмите Enter, чтобы закрыть'
    gets.chomp.to_i
  end

  def options_message
    puts 'Наберите на клавитуре и нажмите Enter, чтобы выбрать действие:'
    puts '1 - Создать станцию'
    puts '2 - Создать маршрут'
    puts '3 - Создать поезд'
    puts '4 - Добавить станцию в маршрут'
    puts '5 - Удалить станцию из маршрута'
    puts '6 - Назначить маршрут поезду'
    puts '7 - Добавить вагон'
    puts '8 - Отцепить вагон'
    puts '9 - Перемещать поезд'
    puts '10 - Список станций'
    puts '11 - Список маршрутов'
    puts '12 - Список поездов'
    puts '13 - Занять объем/место в вагоне'
    puts '0 - Выйти из программы'
  end

  # -------------------------------------------------------------

  def seed
    create_stations
    create_routes
    create_trains
    puts 'Seed успешно активирован.'
    sleep 1.5
  end

  def create_stations
    stations << Station.new('Москва')
    stations << Station.new('Казань')
    stations << Station.new('Санкт-Петербург')
  end

  def create_routes
    routes << Route.new(stations[0].name, stations[2].name, stations)
    add_way_stations!
  end

  def add_way_stations!
    routes[0].add_way_station(stations[1].name)
  end

  def create_trains
    passenger_train = PassengerTrain.new('АА1-БВ')
    trains.push(passenger_train)
    passenger_train.add_route(routes[0])
    passenger_train.attach_wagon(PassengerWagon.new(123))
    passenger_train.attach_wagon(PassengerWagon.new(456))
  end
end
