module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*params)
      params.each do |param|
        define_method(param) do
          instance_variable_get("@#{param}")
        end
        define_method("#{param}_history") do
          instance_variable_get("@#{param}_history")
        end
        define_method("#{param}=") do |value|
          instance_variable_set("@#{param}", value)
          history_values = instance_variable_get("@#{param}_history") || []
          instance_variable_set("@#{param}_history", history_values << value)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      define_method("#{attr_name}") do
        instance_variable_get("@#{attr_name}")
      end
      define_method("@#{attr_name}=") do |value|
        raise TypeError, "Type should be #{attr_class}" unless value.is_a?(attr_class)
        instance_variable_set("@#{attr_name}", value)
      end
    end
  end
end
