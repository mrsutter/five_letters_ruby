# frozen_string_literal: true

module AuthServices
  module Register
    class Contract < BaseContract
      params do
        required(:email).filled(:string)

        required(:password)
          .filled(:string)
          .value(min_size?: User::PASSWORD_MIN_LENGTH)

        required(:password_confirmation)
          .filled(:string)
          .value(min_size?: User::PASSWORD_MIN_LENGTH)

        required(:language_id).filled(:string)
      end

      rule(:email) do
        key.failure('wrong') unless Rails.configuration.x.email_regex.match?(value)
      end

      rule(:email) do
        key.failure('already_taken') if User.find_by(email: value).present?
      end

      rule(:password, :password_confirmation) do
        unless values[:password] == values[:password_confirmation]
          code = 'passwords_are_not_equal'
          key(:password).failure(code)
          key(:password_confirmation).failure(code)
        end
      end

      rule(:language_id) do
        key.failure('not_found') if Language.available.find_by(id: value).blank?
      end
    end
  end
end
