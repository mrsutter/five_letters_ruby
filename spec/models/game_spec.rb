# frozen_string_literal: true

RSpec.describe Game, type: :model do
  describe '#update_after_attempt' do
    subject(:call) { game.update_after_attempt(attempt) }

    context 'when game is won already' do
      let(:game) { create(:game, :won) }
      let(:attempt) { create(:attempt, game: game) }

      it 'does not change attempts count' do
        expect { call }.not_to change(game, :attempts_count)
      end

      it 'does not change state' do
        expect { call }.not_to change(game, :state)
      end
    end

    context 'when game is wasted already' do
      let(:game) { create(:game, :wasted) }
      let(:attempt) { create(:attempt, game: game) }

      it 'does not change attempts count' do
        expect { call }.not_to change(game, :attempts_count)
      end

      it 'does not change state' do
        expect { call }.not_to change(game, :state)
      end
    end

    context 'when attempt belongs to other game' do
      let(:game) { create(:game) }
      let(:attempt) { create(:attempt) }

      it 'does not change attempts count' do
        expect { call }.not_to change(game, :attempts_count)
      end

      it 'does not change state' do
        expect { call }.not_to change(game, :state)
      end
    end

    context 'when attempt was successful' do
      let(:game) { create(:game, :with_attempts, attempts_count: 2) }
      let(:attempt) { create(:attempt, :successful, game: game, number: 3) }

      it 'changes attempts count' do
        expect { call }.to change(game, :attempts_count).by(1)
      end

      it 'changes state to won' do
        expect { call }.to change(game, :state).from('active').to('won')
      end
    end

    context 'when attempt was not successful and it is not last attempt' do
      let(:game) { create(:game, :with_attempts, attempts_count: 2) }
      let(:attempt) { create(:attempt, :unsuccessful, game: game, number: 3) }

      it 'changes attempts count' do
        expect { call }.to change(game, :attempts_count).by(1)
      end

      it 'does not change state' do
        expect { call }.not_to change(game, :state)
      end
    end

    context 'when attempt was not successful and it was last attempt' do
      let(:game) { create(:game, :with_attempts, attempts_count: 5) }
      let(:attempt) { create(:attempt, :unsuccessful, game: game, number: 6) }

      it 'changes attempts count' do
        expect { call }.to change(game, :attempts_count).by(1)
      end

      it 'changes state to wasted' do
        expect { call }.to change(game, :state).from('active').to('wasted')
      end
    end
  end
end
