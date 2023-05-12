# frozen_string_literal: true

module AuthServices
  module Refresh
    module Operations
      class DestroyTokens < BaseOperation
        def call(input)
          input[:refresh_token].destroy!
          Success(input)
        end
      end
    end
  end
end
