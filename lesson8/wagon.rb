# frozen_string_literal: true

# Вагон
class Wagon
  include CompanyManufacturerInfo
  include ValidCheck

  attr_reader :type

  def initialize
    validate!
  end

  protected

  def validate!
    raise 'Type has invalid format' if type != 'пассажирский' && type != 'грузовой'
  end
end
