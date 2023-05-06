# frozen_string_literal: true

RSpec.describe 'Games', type: :request do
  describe 'GET /api/v1/games' do
    let(:url) { '/api/v1/games' }

    it 'returns сorrect status' do
      get url
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/games/:id' do
    let(:url) { '/api/v1/games/7' }

    it 'returns сorrect status' do
      get url
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/games/active' do
    let(:url) { '/api/v1/games/active' }

    it 'returns сorrect status' do
      get url
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/games' do
    let(:url) { '/api/v1/games' }

    it 'returns сorrect status' do
      post url
      expect(response.status).to eq(201)
    end
  end

  describe 'POST /api/v1/games/active/attempts' do
    let(:url) { '/api/v1/games/active/attempts' }

    it 'returns сorrect status' do
      post url
      expect(response.status).to eq(201)
    end
  end
end
