# frozen_string_literal: true

module AuthServices
  module Login
    class Service < BaseService
      step :validate, with: 'shared.validate'
      step :find_user, with: 'operations.find_user'
      step :create_tokens, with: 'shared.create_tokens'
    end
  end
end
