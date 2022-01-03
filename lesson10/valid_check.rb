# frozen_string_literal: true

# Valid Check
module ValidCheck
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end
end
