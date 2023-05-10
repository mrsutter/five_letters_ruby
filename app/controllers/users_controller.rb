# frozen_string_literal: true

class UsersController < ApplicationController
  after_action :set_user_headers

  def show
    render json: UserBlueprint.render(current_user)
  end

  def update
    language = Language.available.find(params[:language_id])
    current_user.update(language: language)
    render json: UserBlueprint.render(current_user)
  end
end
