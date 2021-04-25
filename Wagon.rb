class Wagon
  attr_reader :type
  
  def initialize(num)
    @num = num
  end

  protected

  def attach_to(train) #so that ther is no conflict between the trailed wagons
    @train = train
  end

  def unhook_from(train)
    @train = nil
  end
  
end