# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticate
  include ExceptionHandler

  private

  def service_call(service_class:, args:)
    service = service_class.new
    result = service.call(args)

    raise result.failure if result.failure?

    result.value!
  end

  def set_user_headers
    game_available_at = current_user.game_available_at.f_iso8601
    response.set_header('Next-Game-Available-At', game_available_at)
  end
end
