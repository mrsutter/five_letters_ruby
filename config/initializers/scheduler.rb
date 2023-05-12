# frozen_string_literal: true

scheduler = Rufus::Scheduler.singleton

scheduler.every '30m' do
  DeleteOutdatedTokensJob.perform_later
end

scheduler.every '30s' do
  WasteOutdatedGamesJob.perform_later
end
