# ./Route.rb

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  validate :stations, :first_last_uniq, message: 'First and last stations should by different'
  validate :stations, :each_type, Station

  def initialize(first, last)
    @stations = [first, last]
    validate!
    self.register_instance
  end

  def show_all_stations
    @stations.each { |station| puts station }
  end

  def delete(station)
    @stations.delete(station) if station != stations.first && station != stations.last 
  end

  def add(station)
    @stations.insert(-2, station) if !stations.find { |station| station == station }
  end

end