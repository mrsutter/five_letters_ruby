# frozen_string_literal: true

RSpec.shared_examples 'tokens_response' do
  it 'responds with status 200 and correct data' do
    post url, params: params

    expect(response.status).to eq(200)
    expect(response.headers['Next-Game-Available-At']).to be_nil

    access_token_value = body['access_token']
    refresh_token_value = body['refresh_token']

    expect(access_token_value).to be_present
    expect(refresh_token_value).to be_present
  end
end
