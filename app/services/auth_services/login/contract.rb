# frozen_string_literal: true

module AuthServices
  module Login
    class Contract < BaseContract
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end

      rule(:email) do
        key.failure('wrong') unless Rails.configuration.x.email_regex.match?(value)
      end

      rule(:password, :email) do
        auth_result = User.find_by(email: values[:email])
                          &.authenticate(values[:password])

        if !rule_error?(:email) && !auth_result
          code = 'no_user_with_such_credentials'
          key(:email).failure(code)
          key(:password).failure(code)
        end
      end
    end
  end
end
