class Wagon_cargo < Wagon
  attr_reader :capacity, :used_capacity

  def initialize(num, capacity)
    @num = num
    @type = 'cargo'
    @capacity = capacity
    validate!
    @used_capacity = 0
  end

  def load(volume)
    raise "Not enough space" if (used_capacity + volume) > capacity
    @used_capacity += volume
  end

  def unload(volume)
    raise "The wagon does not have so much load" if (used_capacity - volume).negative?
    @used_capacity -= volume
  end

  def free_capacity
    capacity - used_capacity
  end

  def print_wg
    "Wagon'#{num}', type '#{type}', used capacity '#{used_capacity}', free capacity '#{free_capacity}'"
  end

  protected

  attr_writer :used_capacity

  def validate!
    super
    raise "Amount of capacity should be greater than 0" if capacity <= 0
  end
end