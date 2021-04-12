# ./Station.rb


class Station
  attr_reader :name, :freights, :passeng

  def initialize(name)
    @name = name
    @freights = []
    @passeng = []
    @all = []
  end

  def show_all
    @all.each { |train| puts train.num }
  end

  def show_fr
    @freights.each { |train| puts train.num }
  end

  def show_ps
    @passeng.each { |train| puts train.num }
  end

  def train_departure(train)
    @all.delete(train)
    if train.type == 'freg'
      @freights.delete(train)
    else
      @passeng.delete(train)
      train.go
    end
  end

  def train_arrive(train)
    @all.push(train)
    if train.type == 'freg'
      @freights.push(train)
    else
      @passeng.push(train)
    end
    train.stop
  end
end