# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:slug) { |n| "slug_#{n}" }
    letters { /\A[a-z]+\z/ }

    trait :unavailable do
      available { false }
    end

    trait :en do
      slug { 'en' }
      name { 'English' }
    end

    trait :ru do
      slug { 'ru' }
      name { 'Русский' }
      letters { /\A[а-я]+\z/ }
    end
  end
end
