# ./Train.rb


class Train
  attr_reader :num, :current_speed, :type, :wagons

  def initialize(num)
    @num = num
    @speed = 0
    @wagons = []
  end

  def set_on(route)
    @route = route
    station_change(0)
  end

  def forward
    unless next_station.nil?
      @route.stations[@current_station_index].send :train_departure, self
      station_change(@current_station_index + 1)
    end
  end

  def back
    unless prev_station.nil?
      @route.stations[current_station_index].send :train_departure, self
      station_change(@current_station_index - 1)
    end
  end

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index != @route.stations.size - 1
  end

  def prev_station
    @route.stations[@current_station_index - 1] if @current_station_index != 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def hitch(wagon)
    if @speed.zero? && wagon.type == @type
      @wagons.push(wagon)
    else
      puts 'The train is moving'
    end
  end

  def unhook(wagon)
    if @speed.zero?
      @wagons.delete(wagon)
    else
      puts 'The train is moving'
    end
  end

  protected

    def go
    @current_speed = 50
  end

  def stop
    @current_speed = 0
  end

  def station_change(num) #user not allowed to change station for train
    @current_station_index = num #cause train can move only by one station forward of back
    @route.stations[num].send :train_arrive, self
  end
end