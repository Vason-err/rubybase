# ./Station.rb
require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'
class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains
  NAME_FORMAT = /^[a-z]{1,30}([ \-][a-z]{1,30})?([ \-][a-z]{1,30})?([ \-][\d]{1,4})?$/i

  validate :name, :type, String
  validate :name, :format, NAME_FORMAT, message: 'Invalid station name format'

  def self.all
    @@stations ||= []
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.all << self
    self.register_instance
  end

  def show_trains
    @trains.each { |train| puts train }
  end

  def show_trains_by(type)
    typed = @trains.filter { |train| train.type == type }
    typed.each { |train| puts train }
  end

  def each_train
    @trains.each { |train| yield(train) } if block_given?
  end

  private
  #user is not allowed to move train from station manually 
  def train_departure(train)
    @trains.delete(train)
    train.send :go
  end

  def train_arrive(train)
    @trains.push(train)
    train.send :stop
  end

end