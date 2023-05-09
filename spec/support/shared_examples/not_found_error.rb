# frozen_string_literal: true

RSpec.shared_examples 'not_found_error' do
  it 'returns correct error status and body' do
    expect(response.status).to eq(404)

    expect(response).to match_schema('error')

    expect(body['status']).to eq(404)
    expect(body['code']).to eq('not_found')
    expect(body['message']).to eq('')
    expect(body['details']).to eq([])
  end
end
