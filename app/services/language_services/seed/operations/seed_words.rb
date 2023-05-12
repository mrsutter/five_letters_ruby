# frozen_string_literal: true

module LanguageServices
  module Seed
    module Operations
      class SeedWords < BaseOperation
        attr_reader :input

        def call(input)
          @input = input

          start_update = Time.current
          Language.find_each { |lang| seed_language_words(lang) }
          archive_old_words(start_update)

          Success(input)
        end

        private

        def seed_language_words(lang)
          letters_regexp = Regexp.new(lang.letters)

          File.foreach(words_file(lang)) do |line|
            word = line.chomp.downcase

            next if word.length != Word::LENGTH
            next unless letters_regexp.match?(word)

            w = lang.words.find_or_initialize_by(name: word)
            w.archived = false
            w.updated_at = Time.current
            w.save!
          end
        end

        def archive_old_words(start_update)
          Word.where('updated_at < ?', start_update).update_all(archived: true)
        end

        def words_file(lang)
          "#{input[:params][:words_seed_dir]}/words_#{lang.slug}.txt"
        end
      end
    end
  end
end
