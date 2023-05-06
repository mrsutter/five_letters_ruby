# frozen_string_literal: true

RSpec.describe 'RootPath', type: :request do
  it 'returns correct status' do
    get '/'
    expect(response.status).to eq(404)
  end
end
