require 'bigdecimal'

class Product
  attr_reader :name, :price
  attr_accessor :quantity

  def initialize(name:, quantity:, price:)
    @name = name
    @quantity = quantity.to_i
    @price = BigDecimal(price).to_f
  end

  def valid?
    !name.nil? && !price.nil? && !quantity.nil?
  end

  def unavailable?
    quantity <= 0
  end
end
