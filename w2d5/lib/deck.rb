require_relative 'card.rb'

class Deck

	attr_reader :cards

	def initialize
		@cards = generate_deck
	end

	def generate_deck
		card_array = []
		52.times do |i|
			card_array << Card.new(i+1)
		end
		card_array
	end

	def shuffle
		@cards.shuffle!
	end

end