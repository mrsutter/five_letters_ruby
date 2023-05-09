# frozen_string_literal: true

RSpec.describe 'UnexistingPath', type: :request do
  let(:url) { '/api/v1/unexisting_path' }

  http_methods = %i[get post put patch delete options]

  http_methods.each do |http_method|
    describe http_method do
      before { public_send(http_method, url) }

      it_behaves_like 'not_found_error'
    end
  end
end
