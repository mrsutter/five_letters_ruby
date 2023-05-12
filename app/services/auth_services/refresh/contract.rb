# frozen_string_literal: true

module AuthServices
  module Refresh
    class Contract < BaseContract
      params do
        required(:refresh_token).filled(:string)
      end
    end
  end
end
