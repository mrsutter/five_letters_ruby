# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render json: UserBlueprint.render(current_user)
  end

  def update
    render json: {}
  end
end
