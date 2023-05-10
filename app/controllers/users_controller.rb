# frozen_string_literal: true

class UsersController < ApplicationController
  after_action :set_user_headers

  def show
    render json: UserBlueprint.render(current_user)
  end

  def update
    render json: {}
  end
end
