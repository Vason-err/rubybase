require_relative 'Company'
class Wagon
  include Company
  attr_reader :type

  def initialize(num)
    @num = num
  end
end