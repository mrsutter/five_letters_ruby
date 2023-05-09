# frozen_string_literal: true

FactoryBot.define do
  factory :access_token, class: 'Tokens::AccessToken' do
    association(:user)
    association(:refresh_token)

    transient do
      ttl { Tokens::AccessToken::TTL }
    end

    trait :expired do
      transient do
        ttl { -Tokens::AccessToken::TTL }
      end
    end

    after(:build) do |token, evaluator|
      token.value, token.jti, token.expired_at = JwtToken.generate(
        user_id: token.user_id,
        ttl: evaluator.ttl,
        private_key: Tokens::AccessToken::PRIV_KEY
      )
    end
  end
end
