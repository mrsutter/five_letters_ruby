# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[not_found]

  def not_found
    raise ActiveRecord::RecordNotFound
  end
end
