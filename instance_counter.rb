module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  require_relative 'class_methods'
  require_relative 'instance_methods'
end