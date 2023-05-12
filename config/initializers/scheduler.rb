# frozen_string_literal: true

return if defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'

scheduler = Rufus::Scheduler.singleton

scheduler.every '30m' do
  DeleteOutdatedTokensJob.perform_later
end

scheduler.every '30s' do
  WasteOutdatedGamesJob.perform_later
end
