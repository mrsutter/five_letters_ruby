# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    name { generate_str(language.letters) }

    association :language
  end
end
