# frozen_string_literal: true

module AuthServices
  module Login
    class Container < BaseContainer
      namespace 'operations' do
        register('find_user') do
          AuthServices::Login::Operations::FindUser.new
        end
      end
    end
  end
end
