# frozen_string_literal: true

module Tokens
  class RefreshToken < Token
    PUB_KEY = Rails.configuration.x.refresh_token.public_key
    PRIV_KEY = Rails.configuration.x.refresh_token.private_key
    TTL = Rails.configuration.x.refresh_token.ttl

    has_one :access_token, dependent: :destroy
  end
end
