require 'csv'
require 'byebug'
require_relative 'coin'
require_relative 'content_loader'
require_relative 'order'
require_relative 'currency_helper'
require_relative 'product'

class Machine
  include ContentLoader
  include CurrencyHelper

  attr_reader :products, :coins, :order

  def initialize
    @products = []
    @coins = []

    load_products
    load_coins
  end

  def self.start
    puts 'Hey! Thanks for stopping by!!!'
    new.run
    puts 'Thank you! Have a good day.'
  end

  def run
    initialize_order
    display_products
    selection_menu
    return unless order.valid?

    calculate_change if order.extra_paid?
    return_product
  end

  private

  def initialize_order
    @order = Order.new
  end

  def display_products
    puts 'Here are the list of items available'

    available_products.each { |product| puts "Name: #{product.name}; Price: #{money_to_currency(product.price)}" }
  end

  def selection_menu
    puts 'Please Enter Product Name for Selection'
    product_selection_menu

    puts "You need to enter coins for #{money_to_currency(@order.product.price)} for #{@order.product.name}"
    puts 'Please type q once you submitted'
    puts 'Following are the acceptable payment options: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2'
    amount_selection_menu
  end

  def product_selection_menu
    selected_product_name = gets.chomp
    return unless invalid_entry?(selected_product_name)

    puts 'Product Entered is invalid. Do you want to continue ? Type Y or N'
    yes_no = gets.chomp.downcase

    yes_no.downcase == 'y' ? product_selection_menu : (raise 'We are sorry')
  end

  def amount_selection_menu
    entered_amount = gets.chomp.downcase

    loop do
      break if entered_amount.downcase == 'q' && order.valid?

      handle_payment(entered_amount)
      entered_amount = gets.chomp.downcase
    end

    puts "You have submitted #{money_to_currency(@order.submitted_amount)}. Please wait!"
  end

  def handle_payment(entered_amount)
    coin = map_input_amount_to_coin(entered_amount)

    if coin.nil?
      puts 'Sorry the amount you entered is invalid Please try again.'
    else
      coin.quantity += 1
      @order.submitted_amount += coin.currency_value
      puts order.less_paid? ? 'You need to pay more for the product' : "You've completed the payment, please enter q"
    end
  end

  def invalid_entry?(product_name)
    @order.product = products.find { |product| product.name.downcase == product_name.downcase }
    @order.product.nil?
  end

  def map_input_amount_to_coin(input)
    available_coins.find { |a_coin| a_coin.amount == input }
  end

  def calculate_change
    deducted_coins_quantity = Hash.new(0)
    while order.extra_paid?
      coin = available_coins.reverse.bsearch { |a_coin| a_coin.currency_value <= order.extra_paid }
      handle_insufficient_coins(deducted_coins_quantity) if coin.nil?

      deducted_coins_quantity[coin] += 1
      coin.quantity -= 1
      order.change << coin
    end
  end

  def return_product
    order.product.quantity -= 1

    puts "Here is your product #{order.product.name}\n"
    puts "Please collect your remaining balance of #{money_to_currency(order.returning_change)}\n"
  end

  def handle_insufficient_coins(deducted_coins_quantity)
    deducted_coins_quantity.each { |d_coin, quantity| d_coin.quantity += quantity }
    raise 'Sorry,we dont have enough credit to pay you back.'
  end
end
