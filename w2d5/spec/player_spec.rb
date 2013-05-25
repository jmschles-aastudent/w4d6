require 'player.rb'

describe Player do

	subject(:player) { Player.new("Fabio", 1000000) }

	it "has a name" do
		player.name.should == "Fabio"
	end

	it "starts with an empty hand" do
		player.hand.should be_empty
	end
	
	it "may be initialized with mad flow" do
		player.stack.should == 1000000
	end

end