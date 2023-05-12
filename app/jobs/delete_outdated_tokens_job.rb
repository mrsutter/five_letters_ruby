# frozen_string_literal: true

class DeleteOutdatedTokensJob < ApplicationJob
  queue_as :default

  def perform
    Tokens::RefreshToken.expired.destroy_all
    Tokens::AccessToken.expired.destroy_all
  end
end
