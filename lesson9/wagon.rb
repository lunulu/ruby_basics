# frozen_string_literal: true

# Вагон
class Wagon
  include CompanyManufacturerInfo
  include ValidCheck

  attr_reader :type, :number

  @@number = 1

  def initialize
    @number = @@number
    @@number += 1
    validate!
  end

  protected

  attr_writer :number

  def validate!
    raise 'Type has invalid format' if type != 'пассажирский' && type != 'грузовой'
  end
end
