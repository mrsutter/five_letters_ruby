# frozen_string_literal: true

RSpec.shared_examples 'internal_server_error' do
  it 'returns correct error status and body' do
    expect(response.status).to eq(500)

    expect(response).to match_schema('error')

    expect(body['status']).to eq(500)
    expect(body['code']).to eq('internal_server_error')
    expect(body['message']).to eq('')
    expect(body['details']).to eq([])
  end
end
