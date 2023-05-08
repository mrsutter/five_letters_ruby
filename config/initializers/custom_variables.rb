# frozen_string_literal: true

Rails.application.configure do
  config.x.email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  config.x.min_password_length = 6

  config.x.word_length = 5

  config.x.game_max_attempts_count = 6
  config.x.game_lifecycle_hours = 24

  config.x.access_token.private_key = OpenSSL::PKey::RSA.new(
    ENV.fetch('FL_RUBY_ACCESS_TOKEN_PRIVATE_KEY').gsub('\n', "\n")
  )
  config.x.access_token.public_key = config.x.access_token.private_key.public_key
  config.x.access_token.ttl = ENV.fetch('FL_RUBY_ACCESS_TOKEN_TTL').to_i

  config.x.refresh_token.private_key = OpenSSL::PKey::RSA.new(
    ENV.fetch('FL_RUBY_REFRESH_TOKEN_PRIVATE_KEY').gsub('\n', "\n")
  )
  config.x.refresh_token.public_key = config.x.refresh_token.private_key.public_key
  config.x.refresh_token.ttl = ENV.fetch('FL_RUBY_REFRESH_TOKEN_TTL').to_i
end
