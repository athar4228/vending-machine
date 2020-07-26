require 'coin'

describe Coin do
  subject(:coin) { described_class.new(amount: '£2', currency_value: 2, quantity: 10) }

  describe '#initialize' do
    it 'has amount' do
      expect(coin.amount).to eq '£2'
    end

    it 'has currency_value' do
      expect(coin.currency_value).to eq 2
    end

    it 'has quantity' do
      expect(coin.quantity).to eq 10
    end
  end

  describe '#valid' do
    it 'is valid ' do
      expect(coin).to be_valid
    end
  end
end
