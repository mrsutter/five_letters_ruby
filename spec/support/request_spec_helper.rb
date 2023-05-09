# frozen_string_literal: true

module RequestSpecHelper
  def body
    JSON.parse(response.body)
  end

  def auth_header(token)
    { 'Authorization': "Bearer #{token}" }
  end
end
