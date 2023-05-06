# frozen_string_literal: true

class AuthController < ApplicationController
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
