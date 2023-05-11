# frozen_string_literal: true

module Shared
  module Operations
    class CreateTokens < BaseOperation
      attr_reader :user

      def call(input)
        @user = input[:user]

        refresh_token = create_refresh_token
        access_token = create_access_token(refresh_token: refresh_token)

        input[:tokens] = {
          access_token: access_token.value,
          refresh_token: refresh_token.value
        }

        Success(input)
      end

      private

      def create_refresh_token
        token = user.refresh_tokens.new

        token.value, token.jti, token.expired_at = JwtToken.generate(
          user_id: user.id,
          ttl: Tokens::RefreshToken::TTL,
          private_key: Tokens::RefreshToken::PRIV_KEY
        )

        token.save!
        token
      end

      def create_access_token(refresh_token:)
        token = user.access_tokens.new(refresh_token: refresh_token)

        token.value, token.jti, token.expired_at = JwtToken.generate(
          user_id: user.id,
          ttl: Tokens::AccessToken::TTL,
          private_key: Tokens::AccessToken::PRIV_KEY
        )

        token.save!
        token
      end
    end
  end
end
