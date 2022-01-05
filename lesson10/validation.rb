# frozen_string_literal: true

# Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # Class Methods
  module ClassMethods
    def validate(attr, validation_type, addition = nil)
      name = instance_variable_get("@#{attr}".to_sym)
      case validation_type
      when :presence then raise 'Invalid presence' if name.nil? || name == ''
      when :format then raise 'Invalid format' if name !~ addition
      when :type then raise 'Invalid type' unless name.is_a? addition
      end
    end
  end

  # Instance methods
  module InstanceMethods
    def validate!
      self.class.validate :name, :presence
      self.class.validate :name, :format, self.class.const_get(:FORMAT)
      self.class.validate :name, :type, self.class.const_get(:TYPE)
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
