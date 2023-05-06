# frozen_string_literal: true

class GameBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :state, :attempts_count, :created_at
  end

  view :show do
    include_view :short
    association :attempts, blueprint: AttemptBlueprint
  end
end
