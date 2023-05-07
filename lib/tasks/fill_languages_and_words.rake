# frozen_string_literal: true

require 'csv'

namespace :languages do
  desc 'fills languages and words'
  task fill_languages_and_words: :environment do
    filename = 'lib/tasks/seeds/languages.csv'
    csv = CSV.read(filename, headers: true, col_sep: ';')

    csv.each do |row|
      lang = Language.find_or_initialize_by(slug: row['slug'])
      lang.assign_attributes(
        name: row['name'],
        letters: row['letters'],
        available: row['available']
      )
      lang.save
    end
  end
end
