# ./Route.rb


class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last] 
  end

  def stations_all
    @stations.each { |station| puts station.name }
  end

  def del_stat(station)
    @stations.delete(station)
  end

  def add_stat(station1, station2)
    @stations.insert(station1, station2)
  end
end