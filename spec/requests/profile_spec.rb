# frozen_string_literal: true

RSpec.describe 'Profile', type: :request do
  describe 'GET /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :get }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end

  describe 'PUT /api/v1/profile' do
    let(:url) { '/api/v1/profile' }
    let(:http_method) { :put }

    let(:user) { create(:user) }

    include_examples 'unauthorized_request'
  end
end
