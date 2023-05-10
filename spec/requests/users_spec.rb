# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'GET /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :get }

    let(:user) { create(:user) }
    let(:token) { create(:access_token, user: user) }

    include_examples 'unauthorized_request'

    it 'returns status 200, correct data and headers' do
      get url, headers: auth_header(token.value)

      expect(response.status).to eq(200)

      expect(response).to match_schema('user')

      expect(body['email']).to eq(user.email)

      lang_data = body['language']
      user_lang = user.language
      expect(lang_data['id']).to eq(user_lang.id)
      expect(lang_data['slug']).to eq(user_lang.slug)
      expect(lang_data['name']).to eq(user_lang.name)

      expect(response.headers['Next-Game-Available-At'])
        .to eq(user.game_available_at.f_iso8601)
    end
  end

  describe 'PUT /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :put }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end
end
