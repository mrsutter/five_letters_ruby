# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    render json: GameBlueprint.render(games.ordered, view: :short)
  end

  def show
    game = games.find_by!(id: params[:id])
    render json: GameBlueprint.render(game, view: :show)
  end

  def active
    game = games.active.first!
    render json: GameBlueprint.render(game, view: :show)
  end

  def create
    render json: {}, status: 201
  end

  def create_attempt
    render json: {}, status: 201
  end

  private

  def games
    @games ||= current_user.games
  end
end
