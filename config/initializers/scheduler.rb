# frozen_string_literal: true

no_need_to_run_scheduler = defined?(Rails::Console) ||
                           Rails.env.test? ||
                           File.split($PROGRAM_NAME).last == 'rake' ||
                           File.split($PROGRAM_NAME).last == 'sidekiq'

return if no_need_to_run_scheduler

scheduler = Rufus::Scheduler.singleton

scheduler.every '30m' do
  DeleteOutdatedTokensJob.perform_later
end

scheduler.every '30s' do
  WasteOutdatedGamesJob.perform_later
end
