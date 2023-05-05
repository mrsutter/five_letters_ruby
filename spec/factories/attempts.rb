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
      word { game.puzzled_word.chars.map(&:next).join[0...Word::MAX_LENGTH] }
    end

    after(:build, &:calc_result)
  end
end
