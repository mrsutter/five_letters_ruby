# frozen_string_literal: true

class BaseContainer < Dry::Validation::Contract
  extend Dry::Container::Mixin
  import Shared::Container
end
