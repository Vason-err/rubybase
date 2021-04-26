class RailRoad
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
      new_train
    when 2
      new_station
    when 3
      new_route
    when 4
      new_wagon
    end
  end

  def change
    puts 'Enter 1 to add new station to route'
    puts 'Enter 2 to delete station from route'
    puts 'Enter 3 to set route for train'
    puts 'Enter 4 to hitch wagon to train'
    puts 'Enter 5 to unhook wagon from train'
    puts 'Enter 6 to move train on route'
    num = gets.chomp.to_i
    case num
    when 1
      station_add_to_route
    when 2
      station_delete_from_route
    when 3
      set_route_to_train
    when 4
      wagon_hitch
    when 5
      wagon_delete
    when 6
      move_train
    end
  end

  def all_objects
    puts 'Enter 1 to show all trains'
    puts 'Enter 2 to show all stations'
    puts 'Enter 3 to show all routes'
    puts 'Enter 4 to show all trains on particular station'
    puts 'Enter 5 to show all stations on particular route'
    num = gets.chomp.to_i
    case num 
    when 1
      puts 'All trains on current RailRoad:'
      @trains.each.with_index { |train, index| puts "#{index}: #{train.num}" }
    when 2
      puts 'All stations on current RailRoad:'
      @stations.each.with_index { |station, index| puts "#{index}: #{station.name}" }
    when 3
      puts 'All routes on current RailRoad:'
      @routes.each.with_index { |route, index| puts "#{index}: #{route}" }
    when 4
      puts 'Enter the number of station to show all trains on that station:'
      num = gets.chomp.to_i
      if station?(num)
        @stations[num].show_trains
      else
        puts 'There is no station like this'
      end
    when 5
      puts 'Enter the number of route to show its stations:'
      num = gets.chomp.to_i
      if route?(num)
        @routes.each.with_index { |route, index| puts "#{index}: #{route.stations}"}
      else
        puts 'There is no route like this'
      end
    end
  end

  private

  attr_writer :stations, :routes, :trains, :wagons #so that the user does not fill the array
  #in the array with garbage
  
  def new_train
    puts 'Enter the number for train and its type:'
    num = gets.chomp.to_i
    type = gets.chomp
    if type.include?('passen')
      @trains << Train_passen.new(num)
    else
      @trains << Train_cargo.new(num)
    end
  end

  def new_station
    puts 'Enter the name of station:'
    name = gets.chomp
    @stations << Station.new(name)
  end

  def new_route
    puts 'Enter the numbers of first and last stations in new route:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if station?(num1) && station?(num2)
      @routes << Route.new(@stations[num1], @stations[num2])
    else
      puts 'There is no stations like this'
    end
  end

  def new_wagon
    puts 'Enter the number of wagon and its type'
    num = gets.chomp.to_i
    type = gets.chomp
    if type.include?('passen')
      @wagons << Wagon_passen.new(num)
    else
      @wagons << Wagon_cargo.new(num)
    end
  end

  def station_add_to_route
    puts 'Enter number of route to add station, and number of station:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if route?(num1) && station?(num2)
      @routes[num1].add(@stations[num2])
    else
      puts 'There is no route or station like this'
    end
  end

  def station_delete_from_route
    puts 'Enter number of route in which station will be deleted and number of station:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if route?(num1) && station?(num2)
      @routes[num1].delete(@stations[num2])
    else
      puts 'There is no route or station like this'
    end
  end

  def set_route_to_train
    puts 'Enter number of train which will be set on route, and number of route:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if train?(num1) && route?(num2)
      @trains[num1].set_on(@routes[num2])
    else
      puts 'There is no train or route like this'
    end
  end

  def wagon_hitch
    puts 'Enter number of train to which the wagon will be attached and the number of wagon:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if train?(num1) && wagon?(num2)
      @trains[num1].hitch(@wagons[num2])
    else
      puts 'There is no train or wagon like this'
    end
  end

  def wagon_delete
    puts 'Enter the number of train from which the wagon will be unhooked and the number of wagon:'
    num1 = gets.chomp.to_i
    num2 = gets.chomp.to_i
    if train?(num1) && wagon?(num2)
      @trains[num1].unhook(@wagons[num2])
    else
      puts 'There is no train or wagon like this'
    end
  end

  def move_train
    puts 'Enter the number of train to move, and the direction of movement(forward or back):'
    num = gets.chomp.to_i
    direction = gets.chomp
    if train?(num)
      if direction.include?('forward')
        @trains[num].forward
      else
        @trains[num].back
      end
    else
      puts 'There is no train like this'
    end
  end

  def station?(num)
    num.between? 0, @stations.size - 1
  end

  def route?(num)
    num.between? 0, @routes.size - 1 #the user does not need to use these methods
  end

  def train?(num)
    num.between? 0, @trains.size - 1
  end

  def wagon?(num)
    num.between? 0, @wagons. size - 1
  end
end