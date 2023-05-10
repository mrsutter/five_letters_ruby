# frozen_string_literal: true

module GameServices
  module Create
    module Operations
      class CheckAvailability < BaseOperation
        def call(input)
          user = input[:user]
          return Success(input) if user.game_available_at <= Time.current

          Failure(ServiceError.new(code: :too_early))
        end
      end
    end
  end
end
