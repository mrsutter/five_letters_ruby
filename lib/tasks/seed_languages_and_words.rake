# frozen_string_literal: true

namespace :languages do
  desc 'seeds languages and words'
  task seed: :environment do
    service = LanguageServices::Seed::Service.new
    params = {
      language_seed_file: 'lib/tasks/seeds/languages.csv',
      words_seed_dir: "lib/tasks/seeds/#{Rails.env}"
    }
    service.call(params: params)
  end
end
