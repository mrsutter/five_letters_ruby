# frozen_string_literal: true

RSpec.describe 'Games', type: :request do
  describe 'GET /api/v1/games' do
    let(:url) { '/api/v1/games' }
    let(:http_method) { :get }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'GET /api/v1/games/:id' do
    let(:url) { '/api/v1/games/7' }
    let(:http_method) { :get }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'GET /api/v1/games/active' do
    let(:url) { '/api/v1/games/active' }
    let(:http_method) { :get }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'POST /api/v1/games' do
    let(:url) { '/api/v1/games' }
    let(:http_method) { :post }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'POST /api/v1/games/active/attempts' do
    let(:url) { '/api/v1/games/active/attempts' }
    let(:http_method) { :post }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end
end
