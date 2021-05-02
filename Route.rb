# ./Route.rb

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  def initialize(first, last)
    @first = first
    @last = last
    @stations = [@first, @last]
    self.register_instance
  end

  def show_all_stations
    @stations.each { |station| puts station }
  end

  def delete(station)
    delete_validate!(station)
    @stations.delete(station)
  end

  def add(station)
    add_validate!(station)
    @stations.insert(-2, station)
  end

  protected

  def delete_validate!(stat)
    raise "The route does not have such a station!" if !(stations.find { |station| station == stat })
    raise "You can't delete first and last stations of the route!" if stat != @first && stat != @last
  end

  def add_validate(stat)
    raise "The route already has such a station!" if stations.find { |station| station == stat }
  end
end