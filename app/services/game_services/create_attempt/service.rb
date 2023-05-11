# frozen_string_literal: true

module GameServices
  module CreateAttempt
    class Service < BaseService
      step :validate, with: 'shared.validate'
      step :save_attempt, with: 'operations.save_attempt'
      step :update_game, with: 'operations.update_game'
    end
  end
end
