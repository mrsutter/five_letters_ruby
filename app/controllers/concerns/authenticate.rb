# frozen_string_literal: true

module Authenticate
  class NotAuthenticated < StandardError; end

  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  attr_reader :token, :current_user

  def authenticate_user!
    user_id, jti = JwtToken.decode(
      value: auth_token, public_key: Tokens::AccessToken::PUB_KEY
    )

    @current_user = User.find_by(id: user_id)
    raise NotAuthenticated if user_id.blank?

    @token = Tokens::AccessToken.find_by(jti: jti, user: current_user)
    raise NotAuthenticated if token.blank?
  end

  def auth_token
    request.headers['Authorization'].to_s.sub('Bearer ', '')
  end
end
