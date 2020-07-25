require 'csv'
require 'byebug'
require_relative 'product'

class Machine
  attr_reader :products, :coins

  def initialize
    @products = []
    @coins = []
    load_products
    load_coins
  end

  def self.start
    puts 'Hey! Thanks for stopping by!!!'
    new.run
    puts 'Thank you! Have a good day'
  end

  def run
    display_products
  end

  private

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

  def display_products
    puts 'Here are the list of items available'
    @products.each do |product|
      next if product.unavailable?

      puts "Name: #{product.name}. Price: #{product.price}"
    end
  end
end
