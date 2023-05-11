# frozen_string_literal: true

RSpec.shared_examples 'user_response' do
  it 'returns correct status, data and headers' do
    expect(response.status).to eq(response_status)

    expect(response).to match_schema('user')

    expect(body['email']).to eq(user.email)

    lang_data = body['language']
    expect(lang_data['id']).to eq(language.id)
    expect(lang_data['slug']).to eq(language.slug)
    expect(lang_data['name']).to eq(language.name)

    if with_user_headers
      expect(response.headers['Next-Game-Available-At'])
        .to eq(user.game_available_at.f_iso8601)
    end
  end
end
