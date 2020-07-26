module CurrencyHelper
  def money_to_currency(amount)
    ['£', amount.round(2).to_f.to_s].join('')
  end
end
