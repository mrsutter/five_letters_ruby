# frozen_string_literal: true

class LanguagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    languages = Language.available.ordered
    render json: LanguageBlueprint.render(languages)
  end
end
