# frozen_string_literal: true

module LanguageServices
  module Seed
    class Container < BaseContainer
      namespace 'operations' do
        register('seed_languages') do
          LanguageServices::Seed::Operations::SeedLanguages.new
        end
        register('seed_words') do
          LanguageServices::Seed::Operations::SeedWords.new
        end
      end
    end
  end
end
