# frozen_string_literal: true

# Модуль
module ValidCheck
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
