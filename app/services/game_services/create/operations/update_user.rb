# frozen_string_literal: true

module GameServices
  module Create
    module Operations
      class UpdateUser < BaseOperation
        def call(input)
          game_available_at = input[:game].created_at + Game::LIFECYCLE_HOURS.hours
          input[:user].update(game_available_at: game_available_at)
          Success(input)
        end
      end
    end
  end
end
