class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  NUMBER_FORMAT = /^[a-z0-9]{3}[-]*[a-z0-9]{2}$/i
  NUM_FOR = /^\d+$/

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
    @trains << Train_passen.new('pas-12')
    @trains << Train_cargo.new('car-13')
    @trains[0].set_on(@routes[0])
    @trains[1].set_on(@routes[1])
    @wagons << Wagon_passen.new('12er', 42)
    @wagons << Wagon_cargo.new('13fr', 200)
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
      @trains << Train_passen.new(number)
    else
      @trains << Train_cargo.new(number)
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
    num2 = gets.chomp
    station_valid?(num1)
    station_valid?(num2)
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
    @wagons << Wagon_passen.new(num, num1)
  end

  def new_cargo_wagon(num)
    puts 'Enter the capacity of wagon:'
    num1 = gets.chomp.to_i
    @wagons << Wagon_passen.new(num, num1)
  end

  def station_add_to_route
    puts 'Enter number of route to add station, and number of station:'
    num1 = gets.chomp
    num2 = gets.chomp
    route_valid?(num1)
    station_valid?(num2)
    @routes[num1.to_i].add(@stations[num2.to_i])
  end

  def station_delete_from_route
    puts 'Enter number of route in which station will be deleted and number of station:'
    num1 = gets.chomp
    num2 = gets.chomp
    route_valid?(num1)
    station_valid?(num2)
    @routes[num1.to_i].delete(@stations[num2.to_i])
  end

  def set_route_to_train
    puts 'Enter number of train which will be set on route, and number of route:'
    num1 = gets.chomp
    num2 = gets.chomp
    train_valid?(num1)
    route_valid?(num2)
    @trains[num1.to_i].set_on(@routes[num2.to_i])
  end

  def wagon_hitch
    puts 'Enter number of train to which the wagon will be attached and the number of wagon:'
    num1 = gets.chomp
    num2 = gets.chomp
    train_valid?(num1)
    wagon_valid?(num2)
    @trains[num1.to_i].hitch(@wagons[num2.to_i])
  end

  def wagon_delete
    puts 'Enter the number of train from which the wagon will be unhooked and the number of wagon:'
    num1 = gets.chomp
    num2 = gets.chomp
    train_valid?(num1)
    wagon_valid?(num2)
    @trains[num1.to_i].unhook(@wagons[num2.to_i])
  end

  def move_train
    puts 'Enter the number of train to move, and the direction of movement(forward or back):'
    num = gets.chomp
    direction = gets.chomp
    train_valid?(num)
    if direction.include?('forward')
      @trains[num.to_i].forward
    else
      @trains[num.to_i].back
    end
  end

  def print_all_train_on_station(num)
    puts "Station: #{stations[num].name} (amount of trains: #{stations[num].trains.length})"
    stations[num].each_train do |train|
      puts train.print_tr
      puts 'Wagons:'
      train.each_wagon do |wagon|
        puts wagon.print_wg
      end
    end
  end

  def print_trains_with_wagons
    trains.each_with_index do |train, index|
      puts "#{index}: #{train.print_tr}"
      puts 'Wagons:'
      train.each_wagon do |wagon|
        puts wagon.print_wg
      end
    end
  end

  def print_train_wagons(num)
    puts trains[num].print_tr
    puts 'Wagons:'
    trains[num].each_wagon do |wagon|
      puts wagon.print_wg
    end
  end

  def use_seat
    puts "Enter the number of wagon in which you want to use seat:"
    num = gets.chomp
    raise "you cant load this wagon, cause its type passen" if wagons[num.to_i].type == 'cargo'
    wagon_valid?(num)
    wagons[num.to_i].use_seat
  end

  def load_wagon
    puts "Enter the number of wagon which you want to load:"
    num = gets.chomp
    wagon_valid?(num)
    raise "you cant use seat in this wagon, cause its type cargo" if wagons[num.to_i].type == 'passen'
    puts "Enter the volume of load:"
    num1 = gets.chomp.to_i
    wagons[num.to_i].load(num1)
  end

  def trains_on_station
    puts 'Enter the number of station to show all trains on that station:'
    num = gets.chomp
    station_valid?(num)
    print_all_train_on_station(num.to_i)
  end

  def wagons_of_train
    puts 'Enter the number of train to show its wagons:'
    num = gets.chomp
    train_valid?(num)
    print_train_wagons(num.to_i)
  end

  def trains_on_stations
    stations.each_with_index do |station, index|
      puts "#{index}"
      puts "Station: #{station.name} (amount of trains: #{station.trains.length})"
      station.each_train do |train|
        puts train.print_tr
        puts 'Wagons:'
        train.each_wagon do |wagon|
          puts wagon.print_wg
        end
      end
    end
  end

  def stations_of_route
    puts 'Enter the number of route to show its stations:'
    num = gets.chomp
    route_valid?(num)
    routes[num.to_i].stations.each_with_index { |station, index| puts "#{index}: #{station.name}" }
  end

  def station_valid?(num)
    raise "You can't leave this field blank" if num.empty?
    raise "Incorrect input format" if num !~ NUM_FOR
    raise "There is no station like this" if !(num.to_i.between? 0, @stations.size - 1)
  end

  def route_valid?(num)
    raise "You can't leave this field blank" if num.empty?
    raise "Incorrect input format" if num !~ NUM_FOR
    raise "There is no route like this!" if !(num.to_i.between? 0, @routes.size - 1) #the user does not need to use these methods
  end

  def train_valid?(num)
    raise "You can't leave this field blank" if num.empty?
    raise "Incorrect input format" if num !~ NUM_FOR
    raise "There is no train like this!" if !(num.to_i.between? 0, @trains.size - 1)
  end

  def wagon_valid?(num)
    raise "You can't leave this field blank" if num.empty?
    raise "Incorrect input format" if num !~ NUM_FOR
    raise "There is no wagon like this!" if !(num.to_i.between? 0, @wagons.size - 1)
  end

end