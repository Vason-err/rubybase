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
    @stations.delete(station) if station != stations.first && station != stations.last
  end

  def add_stat(num, station2)
    @stations.insert(num, station2) if num != 0 && num < stations.size
  end
end