# frozen_string_literal: true

module LanguageServices
  module Seed
    class Service < BaseService
      step :seed_languages, with: 'operations.seed_languages'
      step :seed_words, with: 'operations.seed_words'
    end
  end
end
