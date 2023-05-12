# frozen_string_literal: true

RSpec.describe WasteOutdatedGamesJob, type: :job do
  describe '#perform_now' do
    let!(:game) do
      create(:game, created_at: Time.current - Game::LIFECYCLE_HOURS.hours + 1.minute)
    end

    let!(:outdated_game) do
      create(:game, created_at: Time.current - Game::LIFECYCLE_HOURS.hours)
    end

    let!(:won_game) do
      create(:game, :won, created_at: Time.current - Game::LIFECYCLE_HOURS.hours)
    end

    it 'wastes outdated game' do
      expect { described_class.perform_now }
        .to change { outdated_game.reload.state }
        .to('wasted')
    end

    it 'does not waste active game' do
      expect { described_class.perform_now }.not_to(change { game.reload.state })
    end

    it 'does not waste won game' do
      expect { described_class.perform_now }.not_to(change { won_game.reload.state })
    end
  end
end
