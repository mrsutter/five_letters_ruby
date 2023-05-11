# frozen_string_literal: true

module AuthServices
  module Login
    module Operations
      class FindUser < BaseOperation
        def call(input)
          input[:user] = User.find_by!(email: input[:params][:email])
          Success(input)
        end
      end
    end
  end
end
