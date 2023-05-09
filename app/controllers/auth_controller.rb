# frozen_string_literal: true

class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[register login refresh]

  def register
    render json: {}, status: 201
  end

  def login
    render json: {}
  end

  def logout
    render json: {}, status: 204
  end

  def refresh
    render json: {}
  end
end
