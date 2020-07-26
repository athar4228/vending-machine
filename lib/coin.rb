require 'bigdecimal'

class Coin
  attr_reader :amount, :currency_value
  attr_accessor :quantity

  def initialize(amount:, currency_value:, quantity:)
    @amount = amount
    @currency_value = BigDecimal(currency_value, 2).round(2)
    @quantity = quantity.to_i
  end

  def valid?
    !amount.nil? && !currency_value.nil? && !quantity.nil?
  end

  def available?
    quantity.positive?
  end
end
