# ./Station.rb


class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def show_trains
    @trains.each { |train| puts train.num }
  end

  def show_trains_by(type)
    typed = @trains.filter { |train| train.type == type }
    typed.each { |train| puts train.num }
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