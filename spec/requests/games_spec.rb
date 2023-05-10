# frozen_string_literal: true

RSpec.describe 'Games', type: :request do
  let(:user) { create(:user) }
  let(:token) { create(:access_token, user: user) }

  let!(:another_user) { create(:user) }
  let!(:game_of_another_user) do
    create(:game, :with_attempts, attempts_count: 2, user: another_user)
  end

  describe 'GET /api/v1/games' do
    let(:url) { '/api/v1/games' }
    let(:http_method) { :get }
    let!(:wasted_game) do
      create(:game, :wasted, :with_attempts, attempts_count: 2, user: user)
    end
    let!(:active_game) do
      create(:game, :with_attempts, attempts_count: 1, user: user)
    end

    include_examples 'unauthorized_request'

    it 'returns status 200, correct data in correct order and headers' do
      get url, headers: auth_header(token.value)

      expect(response.status).to eq(200)

      expect(response).to match_schema('games')

      expect(body.length).to eq(2)

      [wasted_game, active_game].each_with_index do |game, idx|
        expect(body[idx]['id']).to eq(game.id)
        expect(body[idx]['state']).to eq(game.state)
        expect(body[idx]['attempts_count']).to eq(game.attempts_count)
        expect(body[idx]['created_at']).to eq(game.created_at.f_iso8601)
      end

      expect(response.headers['Next-Game-Available-At'])
        .to eq(user.game_available_at.f_iso8601)
    end
  end

  describe 'GET /api/v1/games/:id' do
    let(:url) { "/api/v1/games/#{game.id}" }
    let(:http_method) { :get }
    let(:game) { create(:game, :with_attempts, attempts_count: 2, user: user) }

    include_examples 'unauthorized_request'

    context 'when incorrect id was sent' do
      before { get url, headers: auth_header(token.value) }

      context 'when unexisting id was sent' do
        let(:url) { '/api/v1/games/unexisting_id' }

        it_behaves_like 'not_found_error'
      end

      context 'when id of game of another user was sent' do
        let(:url) { "/api/v1/games/#{game_of_another_user.id}" }

        it_behaves_like 'not_found_error'
      end
    end

    it 'returns status 200, correct data with attempts in correct order and headers' do
      get url, headers: auth_header(token.value)

      expect(response.status).to eq(200)

      expect(response).to match_schema('game')

      expect(body['id']).to eq(game.id)
      expect(body['state']).to eq(game.state)
      expect(body['attempts_count']).to eq(game.attempts_count)
      expect(body['created_at']).to eq(game.created_at.f_iso8601)

      expect(body['attempts'].length).to eq(2)
      game.attempts.ordered_by_number.each_with_index do |attempt, idx|
        expect(body['attempts'][idx]['number']).to eq(attempt.number)
        expect(body['attempts'][idx]['word']).to eq(attempt.word)
        expect(body['attempts'][idx]['result']).to eq(attempt.result)
      end

      expect(response.headers['Next-Game-Available-At'])
        .to eq(user.game_available_at.f_iso8601)
    end
  end

  describe 'GET /api/v1/games/active' do
    let(:url) { '/api/v1/games/active' }
    let(:http_method) { :get }
    let(:game) { create(:game, :with_attempts, attempts_count: 2, user: user) }

    include_examples 'unauthorized_request'

    context 'when there are no active games' do
      before { get url, headers: auth_header(token.value) }

      it_behaves_like 'not_found_error'
    end

    it 'returns status 200, correct data with attempts in correct order and headers' do
      game

      get url, headers: auth_header(token.value)

      expect(response.status).to eq(200)

      expect(response).to match_schema('game')

      expect(body['id']).to eq(game.id)
      expect(body['state']).to eq(game.state)
      expect(body['attempts_count']).to eq(game.attempts_count)
      expect(body['created_at']).to eq(game.created_at.f_iso8601)

      expect(body['attempts'].length).to eq(2)
      game.attempts.ordered_by_number.each_with_index do |attempt, idx|
        expect(body['attempts'][idx]['number']).to eq(attempt.number)
        expect(body['attempts'][idx]['word']).to eq(attempt.word)
        expect(body['attempts'][idx]['result']).to eq(attempt.result)
      end

      expect(response.headers['Next-Game-Available-At'])
        .to eq(user.game_available_at.f_iso8601)
    end
  end

  describe 'POST /api/v1/games' do
    let(:url) { '/api/v1/games' }
    let(:http_method) { :post }

    include_examples 'unauthorized_request'
  end

  describe 'POST /api/v1/games/active/attempts' do
    let(:url) { '/api/v1/games/active/attempts' }
    let(:http_method) { :post }

    include_examples 'unauthorized_request'
  end
end
