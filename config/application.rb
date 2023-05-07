# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'action_controller/railtie'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'

Bundler.require(*Rails.groups)

module FiveLetters
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    config.active_record.schema_format = :sql

    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc

    config.i18n.available_locales = %i[en]
    config.i18n.default_locale = :en

    config.active_job.queue_adapter = :sidekiq
  end
end
