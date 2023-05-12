# frozen_string_literal: true

Dir[File.join(Rails.root, 'lib', 'active_support', '**', '*.rb')].each { |file| require file }
