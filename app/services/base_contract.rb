# frozen_string_literal: true

class BaseContract < Dry::Validation::Contract
  config.messages.top_namespace = 'dry'
  config.messages.load_paths << 'config/locales/en/dry.yml'
end
