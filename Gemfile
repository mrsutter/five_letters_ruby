# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'aasm'
gem 'bcrypt', '~> 3.1.7'
gem 'blueprinter'
gem 'bootsnap', require: false
gem 'dry-container'
gem 'dry-transaction'
gem 'dry-validation'
gem 'jwt'
gem 'oj'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'redis'
gem 'rufus-scheduler'
gem 'sidekiq', '~> 6.5.5'

group :development, :test do
  gem 'debug', platforms: %i[mri]
  gem 'rspec-rails', '~> 6.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'json-schema'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'string_pattern'
  gem 'timecop'
end
