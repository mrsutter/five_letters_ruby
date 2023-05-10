# frozen_string_literal: true

module GameServices
  module Create
    class Service < BaseService
      step :check_availability, with: 'operations.check_availability'
    end
  end
end
