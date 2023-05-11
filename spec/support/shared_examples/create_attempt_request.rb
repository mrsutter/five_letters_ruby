# frozen_string_literal: true

RSpec.shared_examples 'create_attempt_request' do
  it 'saves in db correctly' do
    expect { request }
      .to change { game.reload.attempts.count }
      .by(1)

    new_attempt = game.attempts.where(word: word.downcase).ordered_by_number.last
    expect(new_attempt).to be_present

    expect(new_attempt.number).to eq(expected_attempt_number)
    expect(new_attempt.result).to eq(expected_attempt_result)

    expect(game.state).to eq(expected_game_state)
    expect(game.attempts_count).to eq(expected_attempt_number)
  end

  it 'returns status 201, correct data and headers' do
    request

    expect(response.status).to eq(201)

    expect(response).to match_schema('game')

    expect(body['id']).to eq(game.id)
    expect(body['state']).to eq(expected_game_state)
    expect(body['attempts_count']).to eq(expected_attempt_number)
    expect(body['created_at']).to eq(game.created_at.f_iso8601)
    expect(body['attempts'].length).to eq(expected_attempt_number)

    attempt = body['attempts'][-1]

    expect(attempt['number']).to eq(expected_attempt_number)
    expect(attempt['word']).to eq(word.downcase)
    expect(attempt['result']).to eq(expected_attempt_result)

    expect(response.headers['Next-Game-Available-At'])
      .to eq(user.game_available_at.f_iso8601)
  end
end
