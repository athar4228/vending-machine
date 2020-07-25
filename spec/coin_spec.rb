require 'coin'

describe Coin do

  subject(:coin) { Coin.new(amount: '£2', currency_value: 2, quantity: 10) }

  context '#initialize' do
    it "has amount" do
      expect(coin.amount).to eq "£2"
    end

    it "has currency_value" do
      expect(coin.currency_value).to eq 2
    end

    it 'has quantity' do
      expect(coin.quantity).to eq 10
    end
  end

  context '#valid' do
    it 'is valid ' do
      expect(coin.valid?).to be_truthy
    end
  end
end
