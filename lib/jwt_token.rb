# frozen_string_literal: true

module JwtToken
  ALG = 'RS256'

  def self.generate(user_id:, ttl:, private_key:)
    curr_time = Time.current
    expires_at = (curr_time + ttl.seconds)
    jti = SecureRandom.uuid

    claims = {
      sub: user_id, jti: jti, exp: expires_at.to_i,
      nbf: curr_time.to_i, iat: curr_time.to_i
    }

    value = JWT.encode(claims, private_key, ALG)
    [value, jti, expires_at]
  end

  def self.decode(value:, public_key:)
    claims = JWT.decode(value, public_key, true, { algorithm: ALG })[0]
    [claims['sub'], claims['jti']]
  rescue StandardError
    nil
  end
end
