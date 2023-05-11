# frozen_string_literal: true

module GameServices
  module Create
    class Service < BaseService
      step :check_availability, with: 'operations.check_availability'
      step :choose_word, with: 'operations.choose_word'
      step :save_game, with: 'operations.save_game'
      step :update_user, with: 'operations.update_user'
    end
  end
end
