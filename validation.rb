module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  class ValidationError < RuntimeError
  end

  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get('@validations')
      errors = []
      validations.each do |validation|
        value = instance_variable_get("@#{validation[:attribute]}")
        error = send validation[:type], value, validation
        errors << error unless error.nil?
      end

      raise ValidationError, errors unless errors.empty?
    end

    def valid?
      validate!
      true
    rescue ValidationError
      false
    end

    private

    def presence(value)
      params[:message] ||= 'Empty line or nil'
      params[:message] if value.nil? || value.empty?
    end

    def format(value, params)
      params[:message] ||= "Не соответствует формату #{params[:param]}"
      params[:message] if value !~ params[:param] #unless params[:param].match(value.to_s) if value !~ params[:param]
    end

    def type(value, params)
      params[:message] ||= "Excepted type #{params[:param]}"
      params[:message] unless value.is_a?(params[:param])
    end

    def first_last_uniq(value, params)
      params[:message] ||= 'First and last elements are equal'
      params[:message] if value.first == value.last
    end

    def positive(value, params)
      params[:message] if value <= 0
    end

    def each_type(value, params)
      params[:message] ||= "Types is not equal #{params[:param]}"
      params[:message] if value.reject { |x| x.is_a?(params[:param]) }.length.nil?
    end

  end

  module ClassMethods
    def inherited(klass)
      klass.instance_variable_set(:@validations, klass.superclass.instance_variable_get(:@validations))
    end

    def validate(*params)
      @validations ||= []

      @validations << {
        attribute: params[0],
        type: params[1],
        param: params[2] || nil,
        message: params.last.is_a?(Hash) && params.last.key?(:message) ? params.last[:message] : nil
      }
    end
  end
end