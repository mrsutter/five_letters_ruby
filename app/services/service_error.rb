# frozen_string_literal: true

class ServiceError < StandardError
  attr_reader :code, :details

  def initialize(msg = nil, code: :input_errors, details: [])
    @details = details
    @code = code

    super(msg)
  end
end
