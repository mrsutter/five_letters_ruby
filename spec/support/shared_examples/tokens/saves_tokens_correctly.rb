# frozen_string_literal: true

RSpec.shared_examples 'saves_tokens_correctly' do
  it 'saves tokens in db correctly' do
    post url, params: params

    _, refresh_token_jti = JwtToken.decode(
      value: body['refresh_token'],
      public_key: Tokens::RefreshToken::PUB_KEY
    )
    refresh_token = Tokens::RefreshToken.find_by(jti: refresh_token_jti)
    expect(refresh_token).to be_present
    expect(refresh_token.user).to eq(user)
    expect(refresh_token.expired_at).to eq(Time.current + Tokens::RefreshToken::TTL)

    _, access_token_jti = JwtToken.decode(
      value: body['access_token'],
      public_key: Tokens::AccessToken::PUB_KEY
    )
    access_token = Tokens::AccessToken.find_by(jti: access_token_jti)
    expect(access_token).to be_present
    expect(access_token.user).to eq(user)
    expect(access_token.refresh_token).to eq(refresh_token)
    expect(access_token.expired_at).to eq(Time.current + Tokens::AccessToken::TTL)
  end
end
