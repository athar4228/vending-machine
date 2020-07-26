require 'order'
require 'product'

describe Order do
  subject(:order) { described_class.new }

  let(:product) { Product.new(name: 'Water', quantity: 1, price: 5) }
  let(:coin1) { Coin.new(amount: '£1', currency_value: 1, quantity: 10) }
  let(:coin2) { Coin.new(amount: '£2', currency_value: 2, quantity: 10) }

  before do
    order.product = product
  end

  describe 'valid?' do
    describe 'when submitted amount is less than product price' do
      before { order.submitted_amount = 0 }

      it 'is invalid' do
        expect(order).not_to be_valid
      end
    end

    describe 'when product quantity is zero' do
      before { order.product.quantity = 0 }

      it 'is invalid' do
        expect(order).not_to be_valid
      end
    end

    describe 'when submitted amount is greater than product price' do
      before { order.submitted_amount = 5 }

      it 'is valid' do
        expect(order).to be_valid
      end
    end
  end

  describe 'extra_paid?' do
    describe 'when paid amount is same product price' do
      before { order.submitted_amount = 5 }

      it 'is false' do
        expect(order).not_to be_extra_paid
      end
    end

    describe 'when paid amount is greater than product price' do
      before { order.submitted_amount = 10 }

      it 'is true' do
        expect(order).to be_extra_paid
      end
    end
  end

  describe 'returning_change' do
    before { order.change = [coin1, coin2] }

    it 'returns total of coins added as change' do
      expect(order.returning_change).to eq(coin1.currency_value + coin2.currency_value)
    end
  end
end
