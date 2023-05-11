# frozen_string_literal: true

RSpec.shared_examples 'input_errors' do
  it 'returns correct error status and body' do
    expect(response.status).to eq(422)

    expect(response).to match_schema('error')

    expect(body['status']).to eq(422)
    expect(body['code']).to eq('input_errors')
    expect(body['message']).to eq('')
    expect(body['details']).to eq(err_details.map(&:stringify_keys))
  end
end
