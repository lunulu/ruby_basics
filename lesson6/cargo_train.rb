# frozen_string_literal: true

# Грузовой поезд
class CargoTrain < Train
  def initialize(number)
    super
    @type = 'грузовой'
  end
end
