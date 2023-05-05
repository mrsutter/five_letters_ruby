# frozen_string_literal: true

module Tokens
  class AccessToken < Token
    belongs_to :refresh_token
  end
end
