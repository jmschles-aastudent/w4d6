class Player

	attr_accessor :hand, :stack, :name

	def initialize(name, stack)
		@name = name
		@hand = []
		@stack = stack
	end

	def make_play
		puts "What do you do?"
		puts "'C' (check), 'B ###' (bet amount), or 'F' (fold)"
		gets.chomp.split
	end

	def discard
		puts "Choose up to three cards to discard."
		puts "Use indices, i.e. '0 2 3'."
		input = gets.chomp.split
		until input.count.between?(0, 3)
			puts "Invalid, please choose between 0 and 3 cards."
			input = gets.chomp.split
		end
		input
	end


end