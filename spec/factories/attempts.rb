# frozen_string_literal: true

FactoryBot.define do
  factory :attempt do
    number { 1 }
    word { generate_str(game.word.language.letters) }

    association :game

    trait :successful do
      word { game.puzzled_word }
    end

    trait :unsuccessful do
      word { generate_str_different_from(game.puzzled_word) }
    end

    after(:build, &:calc_result)
  end
end
