# frozen_string_literal: true

module LanguageServices
  module Seed
    class Contract < BaseContract
      params do
        required(:language_seed_file).filled(:string)
        required(:words_seed_dir).filled(:string)
      end
    end
  end
end
