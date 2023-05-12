# frozen_string_literal: true

module AuthServices
  module Refresh
    class Service < BaseService
      step :validate, with: 'shared.validate'
      step :process_token, with: 'operations.process_token'
      step :destroy_tokens, with: 'operations.destroy_tokens'
      step :create_tokens, with: 'shared.create_tokens'
    end
  end
end
