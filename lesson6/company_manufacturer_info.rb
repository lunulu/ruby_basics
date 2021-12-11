# frozen_string_literal: true

# Информация о компании-производителе
module CompanyManufacturerInfo
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    attr_reader :company_manufacturer_name

    protected

    attr_writer :company_manufacturer_name
  end
end
