# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticate
  include ExceptionHandler

  private

  def set_user_headers
    game_available_at = current_user.game_available_at.f_iso8601
    response.set_header('Next-Game-Available-At', game_available_at)
  end
end
