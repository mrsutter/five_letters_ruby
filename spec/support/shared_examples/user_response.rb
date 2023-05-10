# frozen_string_literal: true

RSpec.shared_examples 'user_response' do
  before do
    public_send(http_method, url, params: params, headers: auth_header(token.value))
  end

  it 'returns status 200, correct data and headers' do
    expect(response.status).to eq(200)

    expect(response).to match_schema('user')

    expect(body['email']).to eq(user.email)

    lang_data = body['language']
    expect(lang_data['id']).to eq(language.id)
    expect(lang_data['slug']).to eq(language.slug)
    expect(lang_data['name']).to eq(language.name)

    expect(response.headers['Next-Game-Available-At'])
      .to eq(user.game_available_at.f_iso8601)
  end
end
