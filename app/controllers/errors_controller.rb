# frozen_string_literal: true

class ErrorsController < ActionController::API
  def not_found
    render json: { code: :not_found }, status: 404
  end
end
