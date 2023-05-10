# frozen_string_literal: true

module GameServices
  module Create
    class Container < BaseContainer
      namespace 'operations' do
        register('check_availability') do
          GameServices::Create::Operations::CheckAvailability.new
        end
      end
    end
  end
end
