# frozen_string_literal: true

module AuthServices
  module Login
    class Service < BaseService
      step :validate, with: 'shared.validate'
    end
  end
end
