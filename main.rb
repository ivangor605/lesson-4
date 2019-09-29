require './station.rb'
require './route.rb'
require './train.rb'
require './CargoCar.rb'
require './PassengerCar.rb'
require './CargoCar.rb'
require './Car.rb'
require './CargoTrain.rb'
require './PassengerTrain.rb'

stations = []
trains = []
routes = []
CAR_TYPES = { 'cargo' => CargoCar, 'passenger' => PassengerCar }.freeze

puts %(
0. Выход
1. Создать поезд
2. Создать станцию
3. Создать маршрут
4. Добавить станцию в маршрут
5. Удалить станцию из маршрута
6. Назначать маршрут поезду
7. Добавлять вагоны к поезду
8. Отцеплять вагоны от поезда
9. Переместить поезд по маршруту вперед
10. Переместить поезд по маршрут назад
11. Список всех станций
12. Список поездов на станции
  )

loop do
  print 'Введите номер необходимой команды: '
  choice = gets.chomp.to_i
  case choice

  when 0
    puts 'Good luck!'
    break

  when 1
    puts 'C каким номером?'
    number = gets.chomp
    puts '1 - пассажирский, 2 - грузовой'
    choice = gets.chomp.to_i
    case choice
    when 1
      train = PassengerTrain.new(number)
      trains << train
      puts "Создан пассажирский поезд №#{train.number}"
    when 2
      train = CargoTrain.new(number)
      trains << train
      puts "Создан грузовой поезд №#{train.number}"
    else
      puts 'Указан неверный вариант типа поезда'
    end

  when 2
    puts 'Введите название станции'
    name = gets.chomp
    stations << Station.new(name)
    puts "открыта станция #{station.name}"

  when 3
    if stations.count < 2
      puts 'Добавьте еще одну станцию'
      next
    end

    puts 'Выберите начальную станцию из списка:'

    show_stations
    from = read_station

    if i < 1 || from.nil?
      puts 'Выбрана неверная станция'
      next
    end

    puts 'Введите конечную станцию из списка:'

    show_stations
    to = read_station

    if i < 1 || from.nil?
      puts 'Выбрана неверная станция'
      next
    end

    if from == to
      puts 'Конечная станция совпадает с начальной'
      next
    end

    routes << Route.new(from, to)

    puts 'Создан маршрут'

  when 4
    puts 'Выберите маршрут из списка:'

    show_routes
    route = read_route

    if i < 1 || route.nil?
      puts 'Выбран неверный маршрут'
      next
    end

    puts 'Выберите станцию из списка:'

    show_stations
    station = read_station

    if i < 1 || station.nil?
      puts 'Выбрана неверная станция'
      next
    end

    route.add_station(station)

  when 5
    puts 'Выберите маршрут из списка:'

    show_routes
    route = read_route

    if i < 1 || route.nil?
      puts 'Выбран неверный маршрут'
      next
    end

    puts 'Выберите станцию из списка:'

    route.stations.each_with_index do |st, i|
      puts "#{i + 1}. #{st.name}"
    end

    station = route.stations[gets.chomp.to_i - 1]

    if i < 1 || station.nil?
      puts 'Выбрана неверная станция'
      next
    end

    route.delete(station)
  when 6
    puts 'Выберите поезд из списка:'

    show_trains
    train = read_train

    if i < 1 || train.nil?
      puts 'Выбран неверный поезд'
      next
    end

    puts 'Выберите маршрут из списка:'

    show_routes
    route = read_route

    if i < 1 || route.nil?
      puts 'Выбран неверный маршрут'
      next
    end

    train.take_route(route)
  when 7
    puts 'Выберите поезд из списка:'

    show_trains
    train = read_train

    if i < 1 || train.nil?
      puts 'Выбран неверный поезд'
      next
    end

    puts 'Выберите вагон из списка:'

    show_cars
    car = read_car

    if i < 1 || car.nil?
      puts 'Выбран неверный поезд'
      next
    end

    train.add_car(car)
  when 8
    puts 'Выберите поезд из списка:'

    show_trains
    train = read_train

    if i < 1 || train.nil?
      puts 'Выбран неверный поезд'
      next
    end

    puts 'Выберите вагон из списка:'

    train.cars.each_with_index do |_car, i|
      puts "Вагон №#{i + 1} "
    end

    car = train.cars[gets.chomp.to_i - 1]

    if i < 1 || car.nil?
      puts 'Выбран неверный поезд'
      next
    end

    train.remove_car(car)

  when 9
    puts 'Выберите поезд из списка:'

    show_trains
    train = read_train

    if i < 1 || train.nil?
      puts 'Выбран неверный поезд'
      next
    end

    train.move_forward

  when 10
    puts 'Выберите поезд из списка:'

    show_trains
    train = read_train

    if i < 1 || train.nil?
      puts 'Выбран неверный поезд'
      next
    end

    train.move_backward

  when 11
    puts 'Список всех станций'
    show_stations

  when 12
    puts 'Выберите станцию из списка:'

    show_stations
    station = read_station

    if i < 1 || station.nil?
      puts 'Выбрана неверная станция'
      next
    end

    station.trains.each_with_index do |tr, i|
      puts "#{i + 1}. #{type} поезд с №#{tr.number}"
    end
  end
end

def show_stations
  stations.each_with_index do |station, i|
    puts "#{i + 1}. #{station.name}"
  end
end

def read_station
  stations[gets.chomp.to_i - 1]
end

def show_routes
  routes.each_with_index do |_route, i|
    puts "Маршрут №#{i + 1} следует по следующим станциям: #{routes.stations.join('-')}"
  end
end

def read_route
  routes[gets.chomp.to_i - 1]
end

def show_trains(trains)
  trains.each_with_index do |train, i|
    puts "#{i + 1}. #{type} поезд с №#{train.number}"
  end
end

def read_train
  trains[gets.chomp.to_i - 1]
end

def show_cars
  cars.each_with_index do |_car, i|
    puts "Вагон №#{i + 1} "
  end
end

def read_car
  car[gets.chomp.to_i - 1]
end
