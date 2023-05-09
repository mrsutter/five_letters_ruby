# frozen_string_literal: true

class GameBlueprint < Blueprinter::Base
  identifier :id

  view :short do
    fields :state, :attempts_count
    field :created_at do |game|
      game.created_at.f_iso8601
    end
  end

  view :show do
    include_view :short
    association :attempts, blueprint: AttemptBlueprint
  end
end
