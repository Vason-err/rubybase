module InstanceMethods
  protected

  def register_instance
    self.class.class_variable_set :@@instances, (self.class.class_variable_get(:@@instances) + 1)
  end
end