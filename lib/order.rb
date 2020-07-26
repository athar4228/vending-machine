class Order
  attr_accessor :product, :submitted_amount, :change

  def initialize
    @submitted_amount = 0
    @change = []
  end

  def valid?
    product.available? && product.price <= submitted_amount
  end

  def less_paid?
    product.price > submitted_amount
  end

  def extra_paid?
    extra_paid.positive?
  end

  def extra_paid
    submitted_amount - product.price - returning_change
  end

  def returning_change
    change.sum(&:currency_value)
  end
end
