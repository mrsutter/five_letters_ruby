# frozen_string_literal: true

module GameServices
  module CreateAttempt
    module Operations
      class UpdateGame < BaseOperation
        def call(input)
          input[:game].update_after_attempt(input[:attempt])
          Success(input)
        end
      end
    end
  end
end
