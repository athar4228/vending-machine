require 'order'
require 'machine'

describe Machine do
  subject(:machine) { described_class.new }

  let(:payment) { '£2' }

  describe 'initialize' do
    it 'has products loaded' do
      expect(machine.products).not_to be nil
    end
  end

  describe 'when run is called' do
    # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
    it 'run steps' do
      machine.send :initialize_order
      expect(machine.order).to be_a Order

      # List of Products
      expect(machine).to receive(:puts).at_least(:once)
      machine.send :display_products

      # Selection of Product
      allow(machine).to receive(:gets).and_return('Water')
      machine.send :product_selection_menu
      expect(machine.order.product).not_to be nil

      product = machine.order.product
      product_count = product.quantity

      # Enter Amount first and then q to exit
      two_pound = machine.send :map_input_amount_to_coin, payment
      old_count = two_pound.quantity

      allow(machine).to receive(:gets).and_return(payment, 'q')
      machine.send :amount_selection_menu
      expect(machine.order.product).not_to be nil
      expect(machine.order).to be_valid

      expect(two_pound.quantity).to eq(old_count + 1)

      # Calculate Change
      expect(machine.order.extra_paid).to be > 0
      machine.send :calculate_change

      expect(machine.order.change.collect(&:amount)).to include('£1')
      expect(machine.order.change.collect(&:amount)).to include('50p')

      machine.send :return_product
      expect(machine.order.product.quantity). to eq(product_count - 1)
    end
    # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
  end
end
