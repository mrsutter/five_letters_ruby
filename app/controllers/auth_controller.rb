# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[register login refresh]

  def register
    result = service_call(
      service_class: AuthServices::Register::Service,
      args: { params: register_params }
    )
    render json: UserBlueprint.render(result[:user]), status: 201
  end

  def login
    result = service_call(
      service_class: AuthServices::Login::Service,
      args: { params: login_params }
    )
    render json: TokensBlueprint.render(result[:tokens])
  end

  def logout
    render json: {}, status: 204
  end

  def refresh
    result = service_call(
      service_class: AuthServices::Refresh::Service,
      args: { params: refresh_params }
    )
    render json: TokensBlueprint.render(result[:tokens])
  end

  private

  def register_params
    @register_params ||= params.permit(
      :email, :password, :password_confirmation, :language_id
    )
  end

  def login_params
    @login_params ||= params.permit(:email, :password)
  end

  def refresh_params
    @refresh_params ||= params.permit(:refresh_token)
  end
end
