# frozen_string_literal: true

# Cargo Wagon
class CargoWagon < Wagon
  attr_reader :total_volume, :volume_occupied

  def initialize(total_volume)
    @type = 'грузовой'
    @total_volume = total_volume
    @volume_occupied = 0
    super()
  end

  def occupy_volume(volume)
    self.volume_occupied += volume if volume_occupied + volume <= total_volume
  end

  def free_volume
    total_volume - volume_occupied
  end

  protected

  attr_writer :total_volume, :volume_occupied

  def validate!
    super
    raise 'The volume cannot be negative' if total_volume.negative?
  end
end
