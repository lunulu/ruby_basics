# frozen_string_literal: true

# Cargo Train
class CargoTrain < Train
  validate :number, :format, /^[а-я0-9]{3}-?[а-я0-9]{2}$/i

  def initialize(number)
    @type = 'грузовой'
    super
  end
end
