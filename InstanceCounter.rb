module InstanceCounter
  def self.included(base)
    base.class_variable_set :@@instances, 0
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  require_relative 'ClassMethods'
  require_relative 'InstanceMethods'
end