module ClassMethods
  def instances
    self.class_variable_get :@@instances
  end
end