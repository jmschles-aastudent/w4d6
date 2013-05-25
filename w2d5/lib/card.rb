class Card

	attr_reader :id, :value, :suit, :name

	def initialize(id)
		@id = id
		@value = (@id / 4) + 1
		@name = get_name
		@suit = get_suit
	end

	def get_name
		value = (@id / 4) + 1
		case value
		when 1
			"A"
		when 11
			"J"
		when 12
			"Q"
		when 13
			"K"
		else
			value.to_s
		end
	end

	def get_suit
		suit_finder = @id % 4
		case suit_finder
		when 1
			:clubs
		when 2
			:diamonds
		when 3
			:hearts
		else
			:spades
		end
	end


end

