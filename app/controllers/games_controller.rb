# frozen_string_literal: true

class GamesController < ApplicationController
  after_action :set_user_headers

  def index
    render json: GameBlueprint.render(games.ordered, view: :short)
  end

  def show
    game = games.find_by!(id: params[:id])
    render json: GameBlueprint.render(game, view: :show)
  end

  def active
    render json: GameBlueprint.render(active_game, view: :show)
  end

  def create
    result = service_call(
      service_class: GameServices::Create::Service,
      args: { user: current_user }
    )
    render json: GameBlueprint.render(result[:game], view: :show), status: :created
  end

  def create_attempt
    result = service_call(
      service_class: GameServices::CreateAttempt::Service,
      args: { game: active_game, params: attempt_params }
    )
    render json: GameBlueprint.render(result[:game], view: :show), status: :created
  end

  private

  def games
    @games ||= current_user.games
  end

  def active_game
    @active_game ||= games.active.first!
  end

  def attempt_params
    @attempt_params ||= params.permit(:word)
  end
end
