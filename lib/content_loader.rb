module ContentLoader
  def load_products
    CSV.foreach('./files/products.csv', headers: true, header_converters: :symbol).each do |row|
      product = Product.new(name: row[:name], quantity: row[:quantity], price: row[:price])
      @products << product if product.valid?
    end
  end

  def load_coins
    CSV.foreach('./files/coins.csv', headers: true, header_converters: :symbol).each do |row|
      coin = Coin.new(amount: row[:amount], currency_value: row[:currency_value], quantity: row[:quantity])
      @coins << coin if coin.valid?
    end
  end

  def available_coins
    coins.select(&:available?).sort_by(&:currency_value)
  end

  def available_products
    products.select(&:available?)
  end
end
