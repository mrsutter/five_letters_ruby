# frozen_string_literal: true

module AuthServices
  module Register
    class Container < BaseContainer
      namespace 'operations' do
        register('create_user') do
          AuthServices::Register::Operations::CreateUser.new
        end
      end
    end
  end
end
