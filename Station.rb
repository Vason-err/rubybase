# ./Station.rb

class Station
  include InstanceCounter
  include Validation
  attr_reader :name

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

  def validate!
    raise "Name should have at least 4 symbols" if name.length < 4 
  end
end