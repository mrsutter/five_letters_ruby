# frozen_string_literal: true

RSpec.describe 'RootPath', type: :request do
  before { get '/' }

  it_behaves_like 'not_found_error'
end
