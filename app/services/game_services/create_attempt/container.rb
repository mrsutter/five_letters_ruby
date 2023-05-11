# frozen_string_literal: true

module GameServices
  module CreateAttempt
    class Container < BaseContainer
      namespace 'operations' do
        register('save_attempt') do
          GameServices::CreateAttempt::Operations::SaveAttempt.new
        end
        register('update_game') do
          GameServices::CreateAttempt::Operations::UpdateGame.new
        end
      end
    end
  end
end
