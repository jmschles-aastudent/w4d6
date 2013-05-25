require 'hand.rb'

describe Hand do

	context "when there's a straight flush" do

		let(:fc1) { double("card", :value => 1, :name => 'A', :suit => :clubs ) }
		let(:fc2) { double("card", :value => 10, :name => '10', :suit => :clubs ) }
		let(:fc3) { double("card", :value => 11, :name => 'J', :suit => :clubs ) }
		let(:fc4) { double("card", :value => 12, :name => 'Q', :suit => :clubs ) }
		let(:fc5) { double("card", :value => 13, :name => 'K', :suit => :clubs ) }

		let(:hand) { Hand.new([fc1, fc2, fc3, fc4, fc5]) }

		it "correctly finds the best hand" do
			hand.evaluate_hand.should == 9
		end

		it "should contain five cards" do
			hand.cards.count.should == 5
		end

		it "finds the high card if it's an ace" do
			hand.high_card.should == 14
		end

		it "should have a straight" do
			hand.should have_straight
		end

		it "should have a flush" do
			hand.should have_flush
		end

		it "should have a straight flush" do
			hand.should have_straight_flush
		end

	end

	context "when there's a full house" do

		let(:fc1) { double("card", :value => 2, :name => '2' ) }
		let(:fc2) { double("card", :value => 2, :name => '2' ) }
		let(:fc3) { double("card", :value => 3, :name => '3' ) }
		let(:fc4) { double("card", :value => 3, :name => '3') }
		let(:fc5) { double("card", :value => 3, :name => '3' ) }

		let(:hand) { Hand.new([fc1, fc2, fc3, fc4, fc5]) }

		it "correctly finds the best hand" do
			hand.evaluate_hand.should == 7
		end

		it "should contain a pair" do
			hand.should have_pair
		end

		it "should contain two pairs" do
			hand.should have_two_pair
		end

		it "should have three of a kind" do
			hand.should have_three_of_a_kind
		end

		it "should have a full house" do
			hand.should have_full_house
		end

	end

	context "when there's four of a kind" do

		let(:fc1) { double("card", :value => 2, :name => '2' ) }
		let(:fc2) { double("card", :value => 3, :name => '3' ) }
		let(:fc3) { double("card", :value => 3, :name => '3' ) }
		let(:fc4) { double("card", :value => 3, :name => '3') }
		let(:fc5) { double("card", :value => 3, :name => '3' ) }

		let(:hand) { Hand.new([fc1, fc2, fc3, fc4, fc5]) }

		it "correctly finds the best hand" do
			hand.evaluate_hand.should == 8
		end

		it "should have four of a kind" do
			hand.should have_four_of_a_kind
		end

	end

end