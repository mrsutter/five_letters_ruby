# frozen_string_literal: true

RSpec.describe LanguageServices::Seed::Service do
  describe '#call' do
    subject(:call) do
      params = {
        language_seed_file: 'lib/tasks/seeds/languages.csv',
        words_seed_dir: "lib/tasks/seeds/#{Rails.env}"
      }
      described_class.new.call(params: params)
    end

    context 'when db is empty' do
      it 'creates languages and words correctly' do
        expect { call }
          .to change(Language, :count).by(2)
          .and change(Word, :count).by(4)

        en_lang = Language.find_by(slug: 'en')
        expect(en_lang).to be_present
        expect(en_lang.name).to eq('English')
        expect(en_lang.letters).to eq('\\A[a-z]+\\z')
        expect(en_lang.available).to be_truthy
        expect(en_lang.words.pluck(:name).sort).to eq(%w[brain lover])
        expect(en_lang.words.pluck(:archived).uniq).to eq([false])

        ru_lang = Language.find_by(slug: 'ru')
        expect(ru_lang).to be_present
        expect(ru_lang.name).to eq('Русский')
        expect(ru_lang.letters).to eq('\\A[а-я]+\\z')
        expect(ru_lang.available).to be_truthy
        expect(ru_lang.words.pluck(:name).sort).to eq(%w[замок пирог])
        expect(ru_lang.words.pluck(:archived).uniq).to eq([false])
      end
    end

    context 'when db is not empty' do
      context 'when language was archived and had a different name' do
        let!(:en_lang) { create(:language, :en, :unavailable, name: 'en') }

        it 'updates attributes' do
          expect { call }
            .to change { en_lang.reload.available }.to(true)
            .and change(en_lang, :name).to('English')
        end
      end

      context 'when word from file was archived earlier' do
        let!(:en_lang) { create(:language, :en, :unavailable, name: 'en') }
        let!(:word) { create(:word, :archived, name: 'lover', language: en_lang) }

        it 'unarchives it' do
          expect { call }.to change { word.reload.archived }.from(true).to(false)
        end
      end

      context 'when word was actual but now it is absent' do
        let!(:en_lang) { create(:language, :en, :unavailable, name: 'en') }
        let!(:word) { create(:word, name: 'pizza', language: en_lang) }

        it 'archives it' do
          expect { call }.to change { word.reload.archived }.from(false).to(true)
        end
      end
    end
  end
end
