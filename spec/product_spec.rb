require 'product'

describe Product do

  subject(:product) { Product.new(name: 'Water', quantity: 2, price: 10) }

  context '#initialize' do
    it "has name" do
      expect(product.name).to eq "Water"
    end

    it "has price" do
      expect(product.price).to eq 10
    end

    it 'has quantity' do
      expect(product.quantity).to eq 2
    end
  end

  context '#valid' do
    it 'is valid ' do
      expect(product.valid?).to be_truthy
    end
  end

  context '#unavailable' do
    it 'is unavailable if quantity is less than or eq 0' do
      product.quantity = 0
      expect(product.unavailable?).to be_truthy
    end
  end
end
