# frozen_string_literal: true

module GameServices
  module CreateAttempt
    class Service < BaseService
      step :validate, with: 'shared.validate'
    end
  end
end
