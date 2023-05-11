# frozen_string_literal: true

class UsersController < ApplicationController
  after_action :set_user_headers

  def show
    render json: UserBlueprint.render(current_user)
  end

  def update
    service_call(
      service_class: UserServices::Update::Service,
      args: { user: current_user, params: update_params }
    )
    render json: UserBlueprint.render(current_user)
  end

  private

  def update_params
    @update_params ||= params.permit(:language_id)
  end
end
