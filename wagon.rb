class Wagon
  include Company
  include Validation
  include Accessors
  attr_reader :type, :number
  #validate :number, :presense
end