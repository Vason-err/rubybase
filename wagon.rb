class Wagon
  include Company
  include Validation
  attr_reader :type, :num

  protected

  def validate!
    raise "Number can't be nil" if num.nil?
    raise "Number should be at least 4 symbols" if num.length < 4
  end
end