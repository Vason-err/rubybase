module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  require_relative 'ClassMethods'
  require_relative 'InstanceMethods'
end