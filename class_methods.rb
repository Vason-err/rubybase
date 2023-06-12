module ClassMethods

  def instances
    @instances ||= 0
  end

  protected
  
  attr_writer :instances
end