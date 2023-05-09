# frozen_string_literal: true

module Tokens
  class AccessToken < Token
    PUB_KEY = Rails.configuration.x.access_token.public_key
    PRIV_KEY = Rails.configuration.x.access_token.private_key
    TTL = Rails.configuration.x.access_token.ttl

    belongs_to :refresh_token
  end
end
