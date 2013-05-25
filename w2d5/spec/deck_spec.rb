require 'deck.rb'

describe Deck do

	subject(:deck) { Deck.new }

	its("cards.count") { should == 52 }

end