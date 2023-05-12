# frozen_string_literal: true

RSpec.describe 'Auth', type: :request do
  describe 'POST /api/v1/auth/register' do
    let(:url) { '/api/v1/auth/register' }

    let(:email) { 'niko_bellic@gta.com' }
    let(:password) { 'helicopter_mission' }
    let(:language) { create(:language, :ru) }

    context 'when data is not correct' do
      context 'when incorrect body was sent' do
        let(:params) { 'wrong body' }
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' },
            { field: 'password_confirmation', code: 'required' },
            { field: 'language_id', code: 'required' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when empty body was sent' do
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' },
            { field: 'password_confirmation', code: 'required' },
            { field: 'language_id', code: 'required' }
          ]
        end

        before { post url }

        it_behaves_like 'input_errors'
      end

      context 'when empty strings were sent' do
        let(:params) do
          { email: '', password: '', password_confirmation: '', language_id: '' }
        end
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' },
            { field: 'password_confirmation', code: 'required' },
            { field: 'language_id', code: 'required' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when email was missed' do
        let(:params) do
          {
            password: password,
            password_confirmation: password,
            language_id: language.id
          }
        end
        let(:err_details) { [{ field: 'email', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when email is incorrect' do
        let(:params) do
          {
            email: 'niko_bellic@',
            password: password,
            password_confirmation: password,
            language_id: language.id
          }
        end
        let(:err_details) { [{ field: 'email', code: 'wrong' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when email is already taken' do
        let(:params) do
          {
            email: email,
            password: password,
            password_confirmation: password,
            language_id: language.id
          }
        end
        let(:err_details) { [{ field: 'email', code: 'already_taken' }] }

        before do
          create(:user, email: email)
          post url, params: params
        end

        it_behaves_like 'input_errors'
      end

      context 'when password was missed' do
        let(:params) do
          { email: email, password_confirmation: password, language_id: language.id }
        end
        let(:err_details) { [{ field: 'password', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when password was too short' do
        let(:params) do
          {
            email: email,
            password: 'gta',
            password_confirmation: password,
            language_id: language.id
          }
        end
        let(:err_details) { [{ field: 'password', code: 'too_short' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when password_confirmation was missed' do
        let(:params) do
          { email: email, password: password, language_id: language.id }
        end
        let(:err_details) { [{ field: 'password_confirmation', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when password confirmation was too short' do
        let(:params) do
          {
            email: email,
            password: password,
            password_confirmation: 'gta',
            language_id: language.id
          }
        end
        let(:err_details) { [{ field: 'password_confirmation', code: 'too_short' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when password and password confirmation do not match' do
        let(:params) do
          {
            email: email,
            password: password,
            password_confirmation: "#{password}-gta",
            language_id: language.id
          }
        end
        let(:err_details) do
          [
            { field: 'password', code: 'passwords_are_not_equal' },
            { field: 'password_confirmation', code: 'passwords_are_not_equal' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when language_id was missed' do
        let(:params) do
          { email: email, password: password, password_confirmation: password }
        end
        let(:err_details) { [{ field: 'language_id', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when language_id does not exist' do
        let(:params) do
          {
            email: email,
            password: password,
            password_confirmation: password,
            language_id: 1
          }
        end
        let(:err_details) { [{ field: 'language_id', code: 'not_found' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when language is unavailable' do
        let(:params) do
          {
            email: email,
            password: password,
            password_confirmation: password,
            language_id: create(:language, :unavailable).id
          }
        end
        let(:err_details) { [{ field: 'language_id', code: 'not_found' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end
    end

    context 'when data is correct' do
      let(:params) do
        {
          email: email,
          password: password,
          password_confirmation: password,
          language_id: language.id
        }
      end

      let(:user) { User.find_by(email: email) }

      before { Timecop.freeze }
      after { Timecop.return }

      it 'saves user in db correctly' do
        expect { post url, params: params }
          .to change(User, :count)
          .by(1)

        expect(user).to be_present

        expect(user.language).to eq(language)
        expect(user.game_available_at).to eq(Time.current)
      end

      describe 'response' do
        let(:response_status) { 201 }
        let(:with_user_headers) { false }

        before { post url, params: params }

        it_behaves_like 'user_response'
      end
    end
  end

  describe 'POST /api/v1/auth/login' do
    let(:url) { '/api/v1/auth/login' }

    let(:email) { 'niko_bellic@gta.com' }
    let(:password) { 'helicopter_mission' }

    let!(:user) { create(:user, email: email, password: password) }

    context 'when data is not correct' do
      context 'when incorrect body was sent' do
        let(:params) { 'wrong body' }
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when empty body was sent' do
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' }
          ]
        end

        before { post url }

        it_behaves_like 'input_errors'
      end

      context 'when empty strings were sent' do
        let(:params) do
          { email: '', password: '' }
        end
        let(:err_details) do
          [
            { field: 'email', code: 'required' },
            { field: 'password', code: 'required' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when email was missed' do
        let(:params) { { password: password } }

        let(:err_details) { [{ field: 'email', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when email is incorrect' do
        let(:params) { { email: 'niko_bellic@', password: password } }

        let(:err_details) { [{ field: 'email', code: 'wrong' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when unexisting email was sent' do
        let(:params) { { email: 'geralt@rivia.com', password: password } }

        let(:err_details) do
          [
            { field: 'email', code: 'no_user_with_such_credentials' },
            { field: 'password', code: 'no_user_with_such_credentials' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when password was missed' do
        let(:params) { { email: email } }

        let(:err_details) { [{ field: 'password', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when wrong password was sent' do
        let(:params) { { email: email, password: "#{password}-gta" } }

        let(:err_details) do
          [
            { field: 'email', code: 'no_user_with_such_credentials' },
            { field: 'password', code: 'no_user_with_such_credentials' }
          ]
        end

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end
    end

    context 'when data is correct' do
      let(:params) { { email: email, password: password } }

      before { Timecop.freeze }
      after { Timecop.return }

      it 'saves new tokens in db' do
        expect { post url, params: params }
          .to change { user.reload.access_tokens.count }.by(1)
          .and change { user.refresh_tokens.count }.by(1)
      end

      include_examples 'tokens_response'
      include_examples 'saves_tokens_correctly'
    end
  end

  describe 'POST /api/v1/auth/logout' do
    let(:url) { '/api/v1/auth/logout' }
    let(:http_method) { :post }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'

    context 'when token is correct' do
      let(:refresh_token) { create(:refresh_token, user: user) }
      let!(:access_token) do
        create(:access_token, user: user, refresh_token: refresh_token)
      end

      it 'destroys old tokens' do
        expect { post url, headers: auth_header(access_token.value) }
          .to change { user.reload.access_tokens.count }.by(-1)
          .and change { user.refresh_tokens.count }.by(-1)

        old_access_token = Tokens::AccessToken.find_by(jti: access_token.jti)
        old_refresh_token = Tokens::RefreshToken.find_by(jti: refresh_token.jti)

        expect(old_access_token).to be_blank
        expect(old_refresh_token).to be_blank
      end

      it 'returns correct status, data and headers' do
        post url, headers: auth_header(access_token.value)

        expect(response.status).to eq(204)
        expect(response.body).to be_blank

        expect(response.headers['Next-Game-Available-At']).to be_nil
      end
    end
  end

  describe 'POST /api/v1/auth/refresh' do
    let(:url) { '/api/v1/auth/refresh' }

    let(:user) { create(:user) }

    context 'when data is not correct' do
      context 'when incorrect body was sent' do
        let(:params) { 'wrong body' }
        let(:err_details) { [{ field: 'refresh_token', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when empty body was sent' do
        let(:err_details) { [{ field: 'refresh_token', code: 'required' }] }

        before { post url }

        it_behaves_like 'input_errors'
      end

      context 'when empty string was sent' do
        let(:params) { { refresh_token: '' } }

        let(:err_details) { [{ field: 'refresh_token', code: 'required' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when wrong token was sent' do
        let(:params) { { refresh_token: 'wrong token' } }

        let(:err_details) { [{ field: 'refresh_token', code: 'wrong' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when expired token was sent' do
        let(:token) { create(:refresh_token, :expired, user: user) }
        let(:params) { { refresh_token: token.value } }

        let(:err_details) { [{ field: 'refresh_token', code: 'wrong' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end

      context 'when not_allowed token was sent' do
        let(:token) { build(:refresh_token, user: user) }
        let(:params) { { refresh_token: token.value } }

        let(:err_details) { [{ field: 'refresh_token', code: 'wrong' }] }

        before { post url, params: params }

        it_behaves_like 'input_errors'
      end
    end

    context 'when data is correct' do
      let(:token) { create(:refresh_token, user: user) }
      let!(:access_token) { create(:access_token, user: user, refresh_token: token) }

      let(:params) { { refresh_token: token.value } }

      before { Timecop.freeze }
      after { Timecop.return }

      include_examples 'tokens_response'
      include_examples 'saves_tokens_correctly'

      it 'destroys old tokens' do
        post url, params: params

        old_access_token = Tokens::AccessToken.find_by(jti: access_token.jti)
        old_refresh_token = Tokens::RefreshToken.find_by(jti: token.jti)

        expect(old_access_token).to be_blank
        expect(old_refresh_token).to be_blank
      end
    end
  end
end
