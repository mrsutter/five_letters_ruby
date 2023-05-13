# frozen_string_literal: true

Dir[Rails.root.join('lib/core_extensions/**/*.rb')].each { |file| require file }

ActiveSupport::TimeWithZone.include CoreExtensions::ActiveSupport::TimeWithZone::Iso8601
