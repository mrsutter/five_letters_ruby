# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  let(:token) { create(:access_token, user: user) }

  describe 'GET /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :get }
    let(:response_status) { 200 }
    let(:with_user_headers) { true }

    let(:user) { create(:user) }
    let(:language) { user.language }

    include_examples 'unauthorized_request'

    describe 'response' do
      before do
        get url, headers: auth_header(token.value)
      end

      it_behaves_like 'user_response'
    end
  end

  describe 'PUT /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :put }

    let(:en_lang) { create(:language, :en) }
    let(:user) { create(:user, language: en_lang) }

    include_examples 'unauthorized_request'

    context 'when data is not correct' do
      context 'when incorrect body was sent' do
        let(:params) { 'wrong body' }
        let(:err_details) { [{ field: 'language_id', code: 'required' }] }

        before do
          put url, params: params, headers: auth_header(token.value)
        end

        it_behaves_like 'input_errors'
      end

      context 'when empty body was sent' do
        let(:err_details) { [{ field: 'language_id', code: 'required' }] }

        before do
          put url, headers: auth_header(token.value)
        end

        it_behaves_like 'input_errors'
      end

      context 'when empty string was sent' do
        let(:params) { { language_id: '' } }
        let(:err_details) { [{ field: 'language_id', code: 'required' }] }

        before do
          put url, params: params, headers: auth_header(token.value)
        end

        it_behaves_like 'input_errors'
      end

      context 'when unexisting language was sent' do
        let(:params) { { language_id: 'unexisting_id' } }

        let(:err_details) { [{ field: 'language_id', code: 'not_found' }] }

        before do
          put url, params: params, headers: auth_header(token.value)
        end

        it_behaves_like 'input_errors'
      end

      context 'when not available language was sent' do
        let(:language) { create(:language, :unavailable, :ru) }
        let(:params) { { language_id: language.id } }

        let(:err_details) { [{ field: 'language_id', code: 'not_found' }] }

        before do
          put url, params: params, headers: auth_header(token.value)
        end

        it_behaves_like 'input_errors'
      end
    end

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

        describe 'response' do
          let(:response_status) { 200 }
          let(:with_user_headers) { true }

          before do
            put url, params: params, headers: auth_header(token.value)
          end

          it_behaves_like 'user_response'
        end
      end

      context 'when old language was sent' do
        let(:language) { en_lang }
        let(:params) { { language_id: language.id } }

        it 'updates value in db' do
          expect { put url, params: params, headers: auth_header(token.value) }
            .not_to(change { user.reload.language })
        end

        describe 'response' do
          let(:response_status) { 200 }
          let(:with_user_headers) { true }

          before do
            put url, params: params, headers: auth_header(token.value)
          end

          it_behaves_like 'user_response'
        end
      end
    end
  end
end
