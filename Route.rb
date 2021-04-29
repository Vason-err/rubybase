# ./Route.rb


class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    self.register_instance
  end

  def show_all_stations
    @stations.each { |station| puts station.name }
  end

  def delete(station)
    @stations.delete(station) if station != stations.first && station != stations.last
  end

  def add(station)
    @stations.insert(-2, station)
  end

end