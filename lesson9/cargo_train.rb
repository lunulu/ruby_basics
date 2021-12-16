# frozen_string_literal: true

# Cargo Train
class CargoTrain < Train
  def initialize(number)
    @type = 'грузовой'
    super
  end
end
