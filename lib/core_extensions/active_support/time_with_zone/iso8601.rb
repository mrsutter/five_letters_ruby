# frozen_string_literal: true

module CoreExtensions
  module ActiveSupport
    module TimeWithZone
      module Iso8601
        def f_iso8601
          utc.iso8601(3)
        end
      end
    end
  end
end
