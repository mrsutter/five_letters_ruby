# frozen_string_literal: true

module Shared
  Container = Dry::Container::Namespace.new('shared') do
    register('validate') { Operations::Validate.new }
    register('create_tokens') { Operations::CreateTokens.new }
  end
end
