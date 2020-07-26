require 'bigdecimal'

class Product
  attr_reader :name, :price
  attr_accessor :quantity

  def initialize(name:, quantity:, price:)
    @name = name
    @quantity = quantity.to_i
    @price = BigDecimal(price).round(2)
  end

  def valid?
    !name.nil? && !price.nil? && !quantity.nil?
  end

  def available?
    quantity.positive?
  end

  def unavailable?
    !available?
  end
end
