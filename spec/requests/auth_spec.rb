# frozen_string_literal: true

RSpec.describe 'Auth', type: :request do
  describe 'POST /api/v1/auth/register' do
    let(:url) { '/api/v1/auth/register' }

    it 'returns сorrect status' do
      post url
      expect(response.status).to eq(201)
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
    let (:http_method) { :post }

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
