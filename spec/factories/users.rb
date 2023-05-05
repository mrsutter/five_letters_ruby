# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:password) { |n| "password-#{n}" }
    game_available_at { Time.current }

    association :language

    trait :game_not_available do
      game_available_at { Time.current + 1.day }
    end
  end
end
