# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    name { generate_str(language.letters) }

    association :language

    trait :archived do
      archived { true }
    end
  end
end
