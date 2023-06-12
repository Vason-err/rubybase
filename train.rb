# ./Train.rb
require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Company
  include InstanceCounter
  include Validation
  include Accessors
  attr_reader :num, :current_speed, :type, :wagons
  attr_accessor_with_history :visited_station

  NUMBER_FORMAT = /^[a-z0-9]{3}[-]*[a-z0-9]{2}$/i

  validate :num, :format, NUMBER_FORMAT, message: 'Invalid number format'

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
    @current_speed = 0
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
    @wagons.push(wagon) if current_speed.zero? && !wagons.find { |wagon| wagon == wagon } && type == wagon.type
  end

  def unhook(wagon)
    @wagons.delete(wagon) if current_speed.zero? && wagons.find { |wagon| wagon == wagon}
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
    self.visited_station = @route.stations[num]
  end
end