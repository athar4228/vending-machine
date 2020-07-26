require 'product'

describe Product do
  subject(:product) { described_class.new(name: 'Water', quantity: 2, price: 10) }

  describe '#initialize' do
    it 'has name' do
      expect(product.name).to eq 'Water'
    end

    it 'has price' do
      expect(product.price).to eq 10
    end

    it 'has quantity' do
      expect(product.quantity).to eq 2
    end
  end

  describe '#valid' do
    it 'is valid ' do
      expect(product).to be_valid
    end
  end

  describe '#unavailable' do
    it 'is unavailable if quantity is less than or eq 0' do
      product.quantity = 0
      expect(product).to be_unavailable
    end
  end

  describe '#available' do
    it 'is available if quantity is less than or eq 0' do
      product.quantity = 2
      expect(product).to be_available
    end
  end
end
