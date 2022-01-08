# frozen_string_literal: true

# Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Class methods
  module ClassMethods
    def validate(var_name, validation_type, params = nil)
      @validations ||= []
      @validations << { var_name: var_name, validation_type: validation_type, params: params }
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
      validations = self.class.instance_variable_get(:@validations)
      validations.each do |validation|
        send "validate_#{validation[:validation_type]}", validation[:var_name], validation[:params]
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

class Test
  include Validation

  validate :name, :presence
  validate :age, :type, Integer
  validate :phone, :format, /^\d{7}$/

  def initialize
    @name = 'aaaa'
    @age = 10
    @phone = '1234567'
  end
end
