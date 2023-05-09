# frozen_string_literal: true

module ActiveSupport
  class TimeWithZone
    def f_iso8601
      utc.iso8601(3)
    end
  end
end
