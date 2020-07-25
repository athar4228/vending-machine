require 'machine'

describe Machine do
  subject(:machine) { Machine.new }

  describe 'load and display products' do
    it 'has products loaded' do
      expect(machine.products).not_to be nil
    end

    it 'calls #display_products' do
      expect(machine).to receive(:puts).and_return('Here are the list of items available').at_least(:once)
      machine.send :display_products
    end
  end
end
