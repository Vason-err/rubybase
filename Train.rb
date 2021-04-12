# ./Train.rb


class Train
  attr_reader :num, :num_of_van
  attr_accessor :type

  def initialize(num, type, num_of_van)
    @num = num
    @type = type
    @num_of_van = num_of_van
    @speed = 0
  end

  def go
    @speed = 50
  end

  def stop
    @speed = 0
  end

  def current_speed
    puts "current_speed: #{@speed}"
  end

  def p_van
    if @speed.zero?
      @num_of_van += 1
    else
      puts 'The train is moving'
    end
  end

  def m_van
    if @speed.zero? && @num_of_van > 0
      @num_of_van -= 1
    else
      puts 'The train is moving'
    end
  end

  def route_set(route)
    @route = route
    self.cur_stat(@route.stations[0])
  end

  def cur_stat(station)
    @cur_stat = station
    @cur_stat.train_arrive(self)
    @stat_num = @route.stations.index(@cur_stat)
  end

  def next_station
    if @route.stations.index(@cur_stat) < @route.stations.size - 1
      @cur_stat.train_departure(self)
      cur_stat(@route.stations[@stat_num + 1])
    end
  end

  def prev_station
    if @route.stations.index(@cur_stat) > 0
      @cur_stat.train.departure(self)
      cur_stat(@route.stations[@stat_num - 1])
    end
  end

  def near_stat
    puts "current station: #{@cur_stat.name}"
    puts "next_station: #{@route.stations[@stat_num + 1].name}" if @stat_num != @route.stations.size
    puts "prev_station: #{@route.stations[@stat_num - 1].name}" if @stat_num != 0
  end
end