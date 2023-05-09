# frozen_string_literal: true

RSpec.shared_examples 'unauthorized_request' do
  before do
    public_send(http_method, url, headers: headers)
  end

  context 'when auth was not correct' do
    context 'when token was not sent' do
      let(:headers) { nil }

      include_examples 'unauthorized_error'
    end

    context 'when token is wrong' do
      let(:headers) { auth_header('wrong token') }

      include_examples 'unauthorized_error'
    end

    context 'when token is expired' do
      let(:expired_token) { create(:access_token, :expired, user: user) }
      let(:headers) { auth_header(expired_token.value) }

      include_examples 'unauthorized_error'
    end

    context 'when token is not allowed' do
      let(:token) { build(:access_token, user: user) }
      let(:headers) { auth_header(token.value) }

      include_examples 'unauthorized_error'
    end
  end
end
