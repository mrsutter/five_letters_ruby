# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    association :user
    word { association :word, language: user.language }

    trait :wasted do
      state { 'wasted' }
    end

    trait :won do
      state { 'won' }
    end

    trait :with_attempts do
      after(:create) do |game|
        game.attempts_count.times do |i|
          game.attempts << create(
            :attempt,
            :unsuccessful,
            game: game,
            number: i + 1
          )
        end
      end
    end
  end
end
