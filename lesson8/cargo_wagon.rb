# frozen_string_literal: true

# Грузовой вагон
class CargoWagon < Wagon
  def initialize
    @type = 'грузовой'
    super
  end
end
