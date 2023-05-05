# frozen_string_literal: true

Rails.application.configure do
  config.x.email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  config.x.min_password_length = 6

  config.x.word_length = 5

  config.x.game_max_attempts_count = 6
  config.x.game_lifecycle_hours = 24
end
