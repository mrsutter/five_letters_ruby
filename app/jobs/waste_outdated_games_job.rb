# frozen_string_literal: true

class WasteOutdatedGamesJob < ApplicationJob
  queue_as :default

  def perform
    Game.active.outdated.find_each do |game|
      game.waste!
    rescue StandardError
      next
    end
  end
end
