# ./Train.rb


class Train
  attr_reader :num, :num_of_van
  attr_accessor :type

  def initialize(num, type, num_of_van)
    @num = num
    @type = type
    @num_of_van = num_of_van
    @speed = 0
  end

  def go
    @speed = 50
  end

  def stop
    @speed = 0
  end

  def current_speed
    puts "current_speed: #{@speed}"
  end

  def add_van
    if @speed.zero?
      @num_of_van += 1
    else
      puts 'The train is moving'
    end
  end

  def del_van
    if @speed.zero? && @num_of_van > 0
      @num_of_van -= 1
    else
      puts 'The train is moving'
    end
  end

  def route_set(route)
    @route = route
    station_change(0)
  end

  def forward_move
    if @current_station < @route.stations.size - 1
      @route.stations[@current_station].train_departure(self)
      station_change(@current_station + 1)
    end
  end

  def backward_move
    if @current_station > 0
      @route.stations[current_station].train.departure(self)
      station_change(@current_station - 1)
    end
  end

  def station_change(num)
    @current_station = num
    @route.stations[num].train_arrive(self)
  end

  def next_station
    puts "next station: #{@route.stations[@current_station + 1].name}" if @current_station != @route.stations.size
  end

  def prev_station
    puts "previous station: #{@route.stations[@current_station - 1].name}" if @current_station != 0
  end

  def current_station
    puts "current station: #{@route.stations[@current_station].name}"
  end
end