# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    render json: {}
  end

  def show
    render json: {}
  end

  def active
    render json: {}
  end

  def create
    render json: {}, status: 201
  end

  def create_attempt
    render json: {}, status: 201
  end
end
