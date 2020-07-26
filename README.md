Vending Machine
==========


● Once an item is selected and the appropriate amount of money is inserted,
the vending machine should return the correct product.

● It should also return change if too much money is provided, or ask for more
money if insufficient funds have been inserted.

● The machine should take an initial load of products and change. The change
will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.

● There should be a way of reloading either products or change at a later point.

● The machine should keep track of the products and change that it contains.

#### Technologies Version
= Ruby and Rspec.

- Gemfile is added to handle respective gems
- .ruby-version is added to configure ruby version
- rubocop is added.

#### Files
/files folder contains files for product and csv.

#### How To Run

- irb
- require './lib/machine.rb'
- vending_machine = Machine.start

#### How to Run rubocop

bundle exec rubocop -c .rubocop.yaml

#### How to Run rspec

bundle exec rspec

#### TODO

Added method to rebuy after product is bought.
