# frozen_string_literal: true

RSpec.describe DeleteOutdatedTokensJob, type: :job do
  describe '#perform_now' do
    let!(:refresh_token) { create(:refresh_token) }
    let!(:access_token) { create(:access_token, refresh_token: refresh_token) }

    let!(:refresh_token_with_expired_access_token) { create(:refresh_token) }

    before do
      create(:access_token, :expired, refresh_token: refresh_token_with_expired_access_token)

      expired_refresh_token = create(:refresh_token, :expired)
      create(:access_token, :expired, refresh_token: expired_refresh_token)
    end

    it 'deletes only outdated tokens' do
      expect { described_class.perform_now }
        .to change(Tokens::RefreshToken, :count)
        .by(-1)
        .and change(Tokens::AccessToken, :count)
        .by(-2)

      expect(Tokens::RefreshToken.find_by(jti: refresh_token.jti))
        .to be_present
      expect(Tokens::AccessToken.find_by(jti: access_token.jti))
        .to be_present
      expect(Tokens::RefreshToken.find_by(jti: refresh_token_with_expired_access_token.jti))
        .to be_present
    end
  end
end
