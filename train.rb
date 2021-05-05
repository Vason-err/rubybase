# ./Train.rb

class Train
  include Company
  include InstanceCounter
  include Validation
  attr_reader :num, :current_speed, :type, :wagons

  NUMBER_FORMAT = /^[a-z0-9]{3}[-]*[a-z0-9]{2}$/i

  class << self
    def all
      @@all ||= []
    end

    def find(num)
      @@all.find { |train| train.num.eql?(num) }
    end
  end

  def initialize(num)
    @num = num
    validate!
    @speed = 0
    @wagons = []
    self.class.all << self
    self.register_instance
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
    wagon_validate!(wagon)
    @wagons.push(wagon)
  end

  def unhook(wagon)
    delete_validate!(wagon)
    @wagons.delete(wagon)
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) } if block_given?
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

  def validate!
    raise "Number can't be nil" if num.nil?
    raise "Number should be at least 5 symbols" if num.length < 5
    raise "Number has invalid format" if num !~ NUMBER_FORMAT
  end

  def wagon_validate!(wag)
    raise "The train is moving" if !(@speed.zero?)
    raise "The types of wagon and train do not match!" if wag.type != type
    raise "The train already has such wagon!" if wagons.find { |wagon| wagon == wag }
  end

  def delete_validate!(wag)
    raise "There is no such wagon in the train!" if !(wagons.find { |wagon| wagon == wag })
    raise "The train is moving" if !(@speed.zero?)
  end
end