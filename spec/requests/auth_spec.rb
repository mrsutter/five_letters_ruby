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

      context 'when all params were missed' do
        let(:params) { {} }
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

        before { post url, params: params }

        it_behaves_like 'user_response'
      end
    end
  end

  describe 'POST /api/v1/auth/login' do
    let(:url) { '/api/v1/auth/login' }

    it 'returns сorrect status' do
      post url
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/auth/logout' do
    let(:url) { '/api/v1/auth/logout' }
    let(:http_method) { :post }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'POST /api/v1/auth/refresh' do
    let(:url) { '/api/v1/auth/refresh' }

    it 'returns сorrect status' do
      post url
      expect(response.status).to eq(200)
    end
  end
end
