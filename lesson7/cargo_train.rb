# frozen_string_literal: true

# Грузовой поезд
class CargoTrain < Train
  def initialize(number)
    @type = 'грузовой'
    super
  end
end
