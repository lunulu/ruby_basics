# frozen_string_literal: true

# Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Class methods
  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(var_name, validation_type, params = nil)
      validations << { var_name: var_name, validation_type: validation_type, params: params }
    end
  end

  # Instance methods
  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate!
      validations = self.class.validations
      validations.each do |validation|
        var = instance_variable_get("@#{validation[:var_name]}")
        send "validate_#{validation[:validation_type]}", var, validation[:params]
      end
    end

    def validate_presence(var, _)
      raise 'Имя не может быть пустой строкой или nil.' if ['', nil].include? var
    end

    def validate_format(var, format)
      raise 'Переменная не соответствует заданному формату' if var !~ format
    end

    def validate_type(var, type)
      raise 'Переменная не соответствует заданному типу' unless var.is_a? type
    end
  end
end
