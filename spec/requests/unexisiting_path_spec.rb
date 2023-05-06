# frozen_string_literal: true

RSpec.describe 'UnexistingPath', type: :request do
  let(:url) { '/api/v1/unexisting_path' }

  http_methods = %w[get post put patch delete head options]

  http_methods.each do |http_method|
    it "returns correct status for #{http_method} method" do
      public_send(http_method, url)
      expect(response.status).to eq(404)
    end
  end
end
