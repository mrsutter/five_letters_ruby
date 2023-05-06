# frozen_string_literal: true

RSpec.describe 'Profile', type: :request do
  describe 'GET /api/v1/profile' do
    let(:url) { '/api/v1/profile' }

    it 'returns сorrect status' do
      get url
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /api/v1/profile' do
    let(:url) { '/api/v1/profile' }

    it 'returns сorrect status' do
      put url
      expect(response.status).to eq(200)
    end
  end
end
