# frozen_string_literal: true

module AuthServices
  module Register
    class Service < BaseService
      step :validate, with: 'shared.validate'
      step :create_user, with: 'operations.create_user'
    end
  end
end
