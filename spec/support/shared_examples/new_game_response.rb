# frozen_string_literal: true

RSpec.shared_examples 'new_game_response' do
  it 'returns status 201, correct data and headers' do
    expect(response.status).to eq(201)

    expect(response).to match_schema('game')

    expect(body['id']).to eq(new_game.id)
    expect(body['state']).to eq(new_game.state)
    expect(body['attempts_count']).to eq(new_game.attempts_count)
    expect(body['created_at']).to eq(new_game.created_at.f_iso8601)
    expect(body['attempts'].length).to eq(0)

    expected_game_available_at = new_game.created_at + Game::LIFECYCLE_HOURS.hours
    expect(response.headers['Next-Game-Available-At'])
      .to eq(expected_game_available_at.f_iso8601)
  end
end
