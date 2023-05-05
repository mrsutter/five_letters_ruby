# frozen_string_literal: true

module Tokens
  class RefreshToken < Token
    has_one :access_token, dependent: :destroy
  end
end
