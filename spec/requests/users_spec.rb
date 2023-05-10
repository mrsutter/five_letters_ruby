# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  let(:token) { create(:access_token, user: user) }

  describe 'GET /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :get }
    let(:params) { nil }

    let(:user) { create(:user) }
    let(:language) { user.language }

    include_examples 'unauthorized_request'

    context 'when token is correct' do
      it_behaves_like 'user_response'
    end
  end

  describe 'PUT /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :put }

    let(:en_lang) { create(:language, :en) }
    let(:user) { create(:user, language: en_lang) }

    include_examples 'unauthorized_request'

    context 'when data is correct' do
      context 'when new language was sent' do
        let(:language) { create(:language, :ru) }
        let(:params) { { language_id: language.id } }

        it 'updates value in db' do
          expect { put url, params: params, headers: auth_header(token.value) }
            .to change { user.reload.language }
            .from(en_lang)
            .to(language)
        end

        it_behaves_like 'user_response'
      end

      context 'when old language was sent' do
        let(:language) { en_lang }
        let(:params) { { language_id: language.id } }

        it 'updates value in db' do
          expect { put url, params: params, headers: auth_header(token.value) }
            .not_to(change { user.reload.language })
        end

        it_behaves_like 'user_response'
      end
    end
  end
end
