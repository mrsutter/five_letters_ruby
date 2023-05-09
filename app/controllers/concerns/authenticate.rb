# frozen_string_literal: true

module Authenticate
  class NotAuthenticated < StandardError; end

  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  def authenticate_user!
    @user_id, jti = JwtToken.decode(
      value: auth_token, public_key: Tokens::AccessToken::PUB_KEY
    )
    raise NotAuthenticated if @user_id.blank?

    token = Tokens::AccessToken.find_by(jti: jti, user_id: @user_id)
    raise NotAuthenticated if token.blank?
  end

  def auth_token
    request.headers['Authorization'].to_s.sub('Bearer ', '')
  end

  def current_user
    @current_user ||= User.find(@user_id)
  end
end
