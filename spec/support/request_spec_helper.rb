# frozen_string_literal: true

module RequestSpecHelper
  def body
    JSON.parse(response.body)
  end
end
