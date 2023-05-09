# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do
      render_error(status: 500, code: :internal_server_error)
    end

    rescue_from Authenticate::NotAuthenticated do
      render_error(status: 401, code: :unauthorized)
    end

    rescue_from ActiveRecord::RecordNotFound do
      render_error(status: 404, code: :not_found)
    end
  end

  def render_error(status:, code:, message: '', details: [])
    err = {
      status: status,
      code: code,
      message: message,
      details: details
    }
    render json: err, status: status
  end
end
