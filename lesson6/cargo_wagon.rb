# frozen_string_literal: true

# Грузовой вагон
class CargoWagon < Wagon
  def initialize
    super
    @type = 'грузовой'
  end
end
