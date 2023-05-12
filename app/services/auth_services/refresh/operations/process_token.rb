# frozen_string_literal: true

module AuthServices
  module Refresh
    module Operations
      class ProcessToken < BaseOperation
        def call(input)
          user_id, jti = JwtToken.decode(
            value: input[:params][:refresh_token],
            public_key: Tokens::RefreshToken::PUB_KEY
          )

          user = User.find_by(id: user_id)
          return failure_result if user.blank?

          token = user.refresh_tokens.find_by(jti: jti)
          return failure_result if token.blank?

          Success(input.merge(user: user, refresh_token: token))
        end

        private

        def failure_result
          Failure(ServiceError.new(details: [{ field: :refresh_token, code: :wrong }]))
        end
      end
    end
  end
end
