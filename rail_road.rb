class RailRoad
  include Validation
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def info
    puts 'creating new object is like for example name_object = Class_name.new'
    puts 'Enter 1 to create new_object'
    puts 'Enter 2 to do operations with created objects'
    puts 'Enter 3 to show information about created objects'
    puts 'Enter 4 to exit'
    num = gets.chomp.to_i
    case num
    when 1
      new_object
    when 2
      change
    when 3
      all_objects
    when 4
      nil
    end
  end

  def new_object
    puts 'Enter 1 to create new train'
    puts 'Enter 2 to create new station'
    puts 'Enter 3 to create new route'
    puts 'Enter 4 to create new wagon'
    num = gets.chomp.to_i
    case num
    when 1
      begin
        new_train
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 2
      begin
        new_station
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 3
      begin
        new_route
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 4
      begin
        new_wagon
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    end
  end

  def change
    puts 'Enter 1 to add new station to route'
    puts 'Enter 2 to delete station from route'
    puts 'Enter 3 to set route for train'
    puts 'Enter 4 to hitch wagon to train'
    puts 'Enter 5 to unhook wagon from train'
    puts 'Enter 6 to move train on route'
    puts 'Enter 7 to use seat on passenger wagon'
    puts 'Enter 8 to load cargo wagon'
    num = gets.chomp.to_i
    case num
    when 1
      begin
        station_add_to_route
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 2
      begin
        station_delete_from_route
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 3
      begin
        set_route_to_train
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 4
      begin
        wagon_hitch
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 5
      begin
        wagon_delete
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 6
      begin
        move_train
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 7
      begin
        use_seat
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 8
      begin
        load_wagon
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    end
  end

  def all_objects
    puts 'Enter 1 to show all trains'
    puts 'Enter 2 to show all stations'
    puts 'Enter 3 to show all routes'
    puts 'Enter 4 to show all trains on particular station'
    puts 'Enter 5 to show all stations on particular route' 
    puts 'Enter 6 to show all wagons of particular train'
    puts 'Enter 7 to show list of trains with its wagons'
    puts 'Enter 8 to show list of stations with trains on it'
    puts 'Enter 9 to show travel history of train'
    puts 'Enter 10 to show using seats history of wagon'
    num = gets.chomp.to_i
    case num 
    when 1
      puts 'All trains on current RailRoad:'
      @trains.each_with_index { |train, index| puts "#{index}: #{train.num}" }
    when 2
      puts 'All stations on current RailRoad:'
      @stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
    when 3
      puts 'All routes on current RailRoad:'
      @routes.each_with_index { |route, index| puts "#{index}: #{route}" }
    when 4
      begin
        trains_on_station
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 5
      begin
        stations_of_route
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 6
      begin
        wagons_of_train
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    when 7
      print_trains_with_wagons
    when 8
      trains_on_stations
    when 9
      begin
        station_history
      rescue RuntimeError =>e
        puts "Exception: #{e.message}"
        retry
      end
    when 10
      begin
        wagon_using_history
      rescue RuntimeError => e
        puts "Exception: #{e.message}"
        retry
      end
    end
  end

  def seed
    @stations << Station.new('fres')
    @stations << Station.new('downtown')
    @stations << Station.new('gregory')
    @stations << Station.new('Vodsan')
    @stations << Station.new('Moscow')
    @routes << Route.new(@stations[0], stations[2])
    @routes[0].add(@stations[1])
    @routes << Route.new(@stations[1], @stations[3])
    @routes[1].add(@stations[4])
    @trains << TrainPassen.new('pas-12')
    @trains << TrainCargo.new('car-13')
    @trains[0].set_on(@routes[0])
    @trains[1].set_on(@routes[1])
    @wagons << WagonPassen.new('12er', 42)
    @wagons << WagonCargo.new('13fr', 200)
    @trains[0].hitch(@wagons[0])
    @trains[1].hitch(@wagons[1])
  end

  private

  attr_writer :stations, :routes, :trains, :wagons #so that the user does not fill the array
  #in the array with garbage
  
  def new_train
    puts 'Enter the number for train:'
    number = gets.chomp
    puts 'Enter the train type(cargo or passen):'
    type = gets.chomp
    if type.include?('passen')
      @trains << TrainPassen.new(number)
    else
      @trains << TrainCargo.new(number)
    end
  end

  def new_station
    puts 'Enter the name of station:'
    name = gets.chomp
    @stations << Station.new(name)
  end

  def new_route
    puts 'Enter the numbers of first and last stations in new route:'
    num1 = gets.chomp
    valid_index(num1, stations)
    num2 = gets.chomp
    valid_index(num2, stations)
    @routes << Route.new(@stations[num1.to_i], @stations[num2.to_i])
  end

  def new_wagon
    puts 'Enter the number of wagon:'
    num = gets.chomp
    puts 'Enter the wagon type(cargo or passen):'
    type = gets.chomp
    if type.include?('passen')
      new_passen_wagon(num)
    else
      new_cargo_wagon(num)
    end
  end

  def new_passen_wagon(num)
    puts 'Enter the number of seats in wagon:'
    num1 = gets.chomp.to_i
    @wagons << WagonPassen.new(num, num1)
  end

  def new_cargo_wagon(num)
    puts 'Enter the capacity of wagon:'
    num1 = gets.chomp.to_i
    @wagons << WagonCargo.new(num, num1)
  end

  def station_add_to_route
    puts 'Enter number of route to add station, and number of station:'
    num1 = gets.chomp
    valid_index(num1, routes)
    num2 = gets.chomp
    valid_index(num2, stations)
    @routes[num1.to_i].add(@stations[num2.to_i])
  end

  def station_delete_from_route
    puts 'Enter number of route in which station will be deleted and number of station:'
    num1 = gets.chomp
    valid_index(num1, routes)
    num2 = gets.chomp
    valid_index(num2, stations)
    @routes[num1.to_i].delete(@stations[num2.to_i])
  end

  def set_route_to_train
    puts 'Enter number of train which will be set on route, and number of route:'
    num1 = gets.chomp
    valid_index(num1, trains)
    num2 = gets.chomp
    valid_index(num2, routes)
    @trains[num1.to_i].set_on(@routes[num2.to_i])
  end

  def wagon_hitch
    puts 'Enter number of train to which the wagon will be attached and the number of wagon:'
    num1 = gets.chomp
    valid_index(num1, trains)
    num2 = gets.chomp
    valid_index(num2, wagons)
    if @trains[num1.to_i].type == @wagons[num2.to_i].type
      @trains[num1.to_i].hitch(@wagons[num2.to_i])
    else
      puts "Types are not equal"
    end
  end

  def wagon_delete
    puts 'Enter the number of train from which the wagon will be unhooked and the number of wagon:'
    num1 = gets.chomp
    valid_index(num1, trains)
    num2 = gets.chomp
    valid_index(num2, wagons)
    @trains[num1.to_i].unhook(@wagons[num2.to_i])
  end

  def move_train
    puts 'Enter the number of train to move, and the direction of movement(forward or back):'
    num = gets.chomp
    direction = gets.chomp
    valid_index(num, trains)
    if direction.include?('forward')
      @trains[num.to_i].forward
    else
      @trains[num.to_i].back
    end
  end

  def print_all_train_on_station(num)
    puts "Station: #{stations[num].name} (amount of trains: #{stations[num].trains.length})"
    stations[num].each_train do |train|
      print_tr(train)
      puts 'Wagons:'
      train.each_wagon do |wagon|
        print_wg(wagon)
      end
    end
  end

  def print_trains_with_wagons
    trains.each_with_index do |train, index|
      puts "#{index}:"
      print_tr(train)
      puts 'Wagons:'
      train.each_wagon do |wagon|
        print_wg(wagon)
      end
    end
  end

  def print_train_wagons(num)
    puts trains[num].print_tr
    puts 'Wagons:'
    trains[num].each_wagon do |wagon|
      print_wg(wagon)
    end
  end

  def use_seat
    puts "Enter the number of wagon in which you want to use seat:"
    num = gets.chomp
    valid_index(num, wagons)
    passen_valid?(num)
    wagons[num.to_i].use_seat
  end

  def load_wagon
    puts "Enter the number of wagon which you want to load:"
    num = gets.chomp
    valid_index(num, wagons)
    cargo_valid?(num)
    puts "Enter the volume of load:"
    num1 = gets.chomp.to_i
    wagons[num.to_i].load(num1)
  end

  def trains_on_station
    puts 'Enter the number of station to show all trains on that station:'
    num = gets.chomp
    valid_index(num, stations)
    print_all_train_on_station(num.to_i)
  end

  def wagons_of_train
    puts 'Enter the number of train to show its wagons:'
    num = gets.chomp
    valid_index(num, trains)
    print_train_wagons(num.to_i)
  end

  def trains_on_stations
    stations.each_with_index do |station, index|
      puts "#{index}"
      puts "Station: #{station.name} (amount of trains: #{station.trains.length})"
      station.each_train do |train|
        print_tr(train)
        puts 'Wagons:'
        train.each_wagon do |wagon|
          print_wg(wagon)
        end
      end
    end
  end

  def print_wg(wagon)
    if wagon.type == 'cargo'
      puts "Wagon: #{wagon.number}, type: #{wagon.type}, used capacity: #{wagon.used_capacity}, free capacity: #{wagon.free_capacity}"
    else
      puts "Wagon: #{wagon.number}, type: #{wagon.type}, used seats: #{wagon.number_of_used_seats}, free seats: #{wagon.number_of_free_seats}"
    end
  end

  def print_tr(train)
    puts "Train: #{train.num}, type: #{train.type}, amount of wagons: #{train.wagons.length}"
  end

  def stations_of_route
    puts 'Enter the number of route to show its stations:'
    num = gets.chomp
    valid_index(num, routes)
    routes[num.to_i].stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
  end

  def wagon_using_history
    puts 'Enter the number of wagon to show its using history'
    num = gets.chomp
    valid_index(num, wagons)
    if wagons[num.to_i].type == 'cargo'
      capacity_using_history(num.to_i)
    else
      seats_using_history(num.to_i)
    end
  end

  def seats_using_history(num)
    puts 'Wagon seats using history:'
    wagons[num].seats_using_history.each_with_index do |seat, index|
      puts "[#{index}] [#{seat}]"
    end
  end

  def capacity_using_history(num)
    puts 'Wagon capacity using history:'
    wagons[num].capacity_using_history.each_with_index do |capacity, index|
      puts "[#{index}] [#{capacity}]"
    end
  end

  def station_history
    puts 'Enter number of train to show its travel history'
    num = gets.chomp
    valid_index(num, trains)
    trains[num.to_i].visited_station_history.each_with_index do |station, index|
      puts "[#{index}] #{station.name}"
    end
  end

  def valid_index(index, object)
    raise "There is no index like this" if index != "#{index.to_i}" || object[index.to_i].nil? || index.nil?
  end

  def cargo_valid?(num)
    raise "this wagon type cargo" if wagons[num.to_i].type == 'passen'
  end

  def passen_valid?(num)
    raise "this wagon type passen" if wagons[num.to_i].type == 'cargo'
  end

end