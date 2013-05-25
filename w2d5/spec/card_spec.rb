
require 'card.rb'

describe Card do

	context "when a card has id 30" do

		subject (:card) { Card.new(30) }

		its(:id) { should == 30 }
		its(:name) { should == "8" }
		its(:value) { should == 8 }
		its(:suit) { should == :diamonds }

	end
	
end