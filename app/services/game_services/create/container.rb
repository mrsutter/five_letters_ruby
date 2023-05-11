# frozen_string_literal: true

module GameServices
  module Create
    class Container < BaseContainer
      namespace 'operations' do
        register('check_availability') do
          GameServices::Create::Operations::CheckAvailability.new
        end
        register('choose_word') do
          GameServices::Create::Operations::ChooseWord.new
        end
        register('save_game') do
          GameServices::Create::Operations::SaveGame.new
        end
        register('update_user') do
          GameServices::Create::Operations::UpdateUser.new
        end
      end
    end
  end
end
