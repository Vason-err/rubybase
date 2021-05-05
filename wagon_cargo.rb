class WagonCargo < Wagon
  attr_reader :capacity, :used_capacity

  def initialize(num, capacity)
    @num = num
    @type = 'cargo'
    @capacity = capacity
    validate!
    @used_capacity = 0
  end

  def load(volume)
    load_valid?(volume)
    @used_capacity += volume
  end

  def unload(volume)
    unload_valid?(volume)
    @used_capacity -= volume
  end

  def free_capacity
    capacity - used_capacity
  end

  protected

  attr_writer :used_capacity

  def validate!
    super
    raise "Amount of capacity should be greater than 0" if capacity <= 0
  end

  def load_valid?(volume)
    raise "Not enough space" if (used_capacity + volume) > capacity
  end

  def unload_valid?(volume)
    raise "The wagon does not have so much load" if (used_capacity - volume).negative?
  end
end