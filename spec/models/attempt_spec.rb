# frozen_string_literal: true

RSpec.describe Attempt, type: :model do
  describe '#successful' do
    context 'when attempt was successful' do
      let(:attempt) { build(:attempt, :successful) }

      it 'returns true' do
        expect(attempt.successful?).to eq(true)
      end
    end

    context 'when attempt was unsuccessful' do
      let(:attempt) { build(:attempt, :unsuccessful) }

      it 'returns false' do
        expect(attempt.successful?).to eq(false)
      end
    end
  end

  describe '#calc_result' do
    tests = [
      {
        word: 'index', puzzled_word: 'pizza',
        result: %w[wrong_place absence absence absence absence]
      },
      {
        word: 'index', puzzled_word: 'upset',
        result: %w[absence absence absence match absence]
      },
      {
        word: 'agent', puzzled_word: 'brand',
        result: %w[wrong_place absence absence match absence]
      },
      {
        word: 'lease', puzzled_word: 'money',
        result: %w[absence wrong_place absence absence absence]
      },
      {
        word: 'offer', puzzled_word: 'order',
        result: %w[match absence absence match match]
      },
      {
        word: 'proxy', puzzled_word: 'quota',
        result: %w[absence absence match absence absence]
      },
      {
        word: 'stock', puzzled_word: 'value',
        result: %w[absence absence absence absence absence]
      },
      {
        word: 'fraud', puzzled_word: 'hedge',
        result: %w[absence absence absence absence wrong_place]
      },
      {
        word: 'truck', puzzled_word: 'abort',
        result: %w[wrong_place wrong_place absence absence absence]
      },
      {
        word: 'pizza', puzzled_word: 'pizza',
        result: %w[match match match match match]
      },
      {
        word: 'кошка', puzzled_word: 'толпа',
        result: %w[absence match absence absence match]
      },
      {
        word: 'кулич', puzzled_word: 'кашпо',
        result: %w[match absence absence absence absence]
      },
      {
        word: 'штора', puzzled_word: 'арбуз',
        result: %w[absence absence absence wrong_place wrong_place]
      },
      {
        word: 'плита', puzzled_word: 'пушка',
        result: %w[match absence absence absence match]
      },
      {
        word: 'пицца', puzzled_word: 'зелье',
        result: %w[absence absence absence absence absence]
      },
      {
        word: 'мороз', puzzled_word: 'волна',
        result: %w[absence match absence absence absence]
      },
      {
        word: 'линза', puzzled_word: 'левша',
        result: %w[match absence absence absence match]
      },
      {
        word: 'пилка', puzzled_word: 'пилот',
        result: %w[match match match absence absence]
      },
      {
        word: 'товар', puzzled_word: 'актор',
        result: %w[wrong_place wrong_place absence wrong_place match]
      },
      {
        word: 'пицца', puzzled_word: 'пицца',
        result: %w[match match match match match]
      }
    ]

    tests.each do |test|
      it "returns correct result for #{test[:word]} and #{test[:puzzled_word]}" do
        word = build(:word, name: test[:puzzled_word])
        game = build(:game, word: word)
        attempt = build(:attempt, word: test[:word], game: game)

        expect(attempt.result).to eq(test[:result])
      end
    end
  end
end
