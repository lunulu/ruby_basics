# frozen_string_literal: true

# Модуль
module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  # Методы класса
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # Инстанс-методы
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
