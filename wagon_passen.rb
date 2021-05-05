class WagonPassen < Wagon
  attr_reader :number_of_seats, :seats

  def initialize(num, number_of_seats)
    @num = num
    @type = 'passen'
    @number_of_seats = number_of_seats
    @seats = []
  end

  def number_of_used_seats
    seats.length
  end

  def number_of_free_seats
    number_of_seats - number_of_used_seats
  end

  def use_seat
    free_seat?
    seats << 1
  end

  def leave_seat
    used_seat?
    seats.pop
  end

  protected

  attr_writer :seats

  def validate!
    super
    raise "Number of seats in wagon should be greater than 0!" if number_of_seats <= 0
  end

  def free_seat?
    raise "There is no free seats in this wagon" if number_of_used_seats >= number_of_seats
  end

  def used_seat?
    raise "All seats are free" if number_of_free_seats == number_of_seats
  end
end