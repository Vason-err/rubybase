module InstanceMethods
  protected

  def register_instance
    self.class.send("instances=", self.class.instances + 1)
  end
end