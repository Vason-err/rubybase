class WagonCargo < Wagon
  attr_reader :capacity, :used_capacity
  attr_accessor_with_history :capacity_using
  validate :capacity, :positive, message: 'Amount of capacity should be greater than 0'

  def initialize(number, capacity)
    @number = number
    @type = 'cargo'
    @capacity = capacity
    validate!
    @used_capacity = 0
  end

  def load(volume)
    load_valid?(volume)
    @used_capacity += volume
    self.capacity_using = self.used_capacity
  end

  def unload(volume)
    unload_valid?(volume)
    @used_capacity -= volume
    self.capacity_using = self.used_capacity
  end

  def free_capacity
    capacity - used_capacity
  end

  protected

  attr_writer :used_capacity

  def load_valid?(volume)
    raise "Not enough space" if (used_capacity + volume) > capacity
  end

  def unload_valid?(volume)
    raise "The wagon does not have so much load" if (used_capacity - volume).negative?
  end
end