# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token, class: 'Tokens::RefreshToken' do
    association(:user)

    transient do
      ttl { Tokens::RefreshToken::TTL }
    end

    trait :expired do
      transient do
        ttl { -Tokens::RefreshToken::TTL }
      end
    end

    after(:build) do |token, evaluator|
      token.value, token.jti, token.expired_at = JwtToken.generate(
        user_id: token.user_id,
        ttl: evaluator.ttl,
        private_key: Tokens::RefreshToken::PRIV_KEY
      )
    end
  end
end
