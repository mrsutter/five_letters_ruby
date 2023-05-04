# frozen_string_literal: true

RSpec.describe 'Languages', type: :request do
  describe 'GET /api/v1/languages' do
    let(:url) { '/api/v1/languages' }

    let!(:en_lang) { create(:language, :en) }

    context 'when all languages are available' do
      let!(:ru_lang) { create(:language, :ru) }

      it 'returns сorrect status and all languages' do
        get url

        expect(response.status).to eq(200)
        expect(response).to match_schema('languages')
        expect(body.size).to eq(2)

        [en_lang, ru_lang].each_with_index do |lang, i|
          lang_data = body[i]

          expect(lang_data['id']).to eq(lang.id)
          expect(lang_data['slug']).to eq(lang.slug)
          expect(lang_data['name']).to eq(lang.name)
        end
      end
    end

    context 'when not all languages are available' do
      before { create(:language, :ru, :unavailable) }

      it 'returns сorrect status and all available languages' do
        get url

        expect(response.status).to eq(200)
        expect(response).to match_schema('languages')
        expect(body.size).to eq(1)

        lang_data = body[0]
        expect(lang_data['id']).to eq(en_lang.id)
        expect(lang_data['slug']).to eq(en_lang.slug)
        expect(lang_data['name']).to eq(en_lang.name)
      end
    end
  end
end
