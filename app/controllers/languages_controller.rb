# frozen_string_literal: true

class LanguagesController < ApplicationController
  def index
    languages = Language.available.ordered
    render json: LanguageBlueprint.render(languages)
  end
end
