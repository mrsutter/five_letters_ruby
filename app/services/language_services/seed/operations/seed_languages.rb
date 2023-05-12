# frozen_string_literal: true

require 'csv'

module LanguageServices
  module Seed
    module Operations
      class SeedLanguages < BaseOperation
        attr_reader :input

        def call(input)
          @input = input

          csv = CSV.read(file, headers: true, col_sep: ';')
          csv.each { |row| save_language(row) }

          Success(input)
        end

        private

        def save_language(data)
          lang = Language.find_or_initialize_by(slug: data['slug'])

          lang.assign_attributes(
            name: data['name'],
            letters: data['letters'],
            available: data['available']
          )

          lang.save!
        end

        def file
          @file ||= input[:params][:language_seed_file]
        end
      end
    end
  end
end
