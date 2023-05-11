# frozen_string_literal: true

module AuthServices
  module Register
    module Operations
      class CreateUser < BaseOperation
        def call(input)
          params = input[:params]

          user = User.create!(
            email: params[:email],
            password: params[:password],
            language_id: params[:language_id],
            game_available_at: Time.current
          )

          input[:user] = user
          Success(input)
        end
      end
    end
  end
end
