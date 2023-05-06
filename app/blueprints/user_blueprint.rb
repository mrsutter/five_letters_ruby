# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  field :email
  association :language, blueprint: LanguageBlueprint
end
