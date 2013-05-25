# TO DO: Define <=> operator inside the hand class so hands can be compared
# Also include "Comparable" to gain access to other badass methods

class Hand

	attr_reader :cards

	def initialize(cards)
		@cards = cards
	end

	def evaluate_hand
		return 9 if has_straight_flush?
		return 8 if has_four_of_a_kind?
		return 7 if has_full_house?
		return 6 if has_flush?
		return 5 if has_straight?
		return 4 if has_three_of_a_kind?
		return 3 if has_two_pair?
		return 2 if has_pair?
		return high_card
	end

	def has_straight_flush?
		has_straight? && has_flush?
	end

	def has_four_of_a_kind?
		return true if get_pairs.uniq.count == get_pairs.count - 5
		false
	end

	def has_full_house?
		return true if get_pairs.count == 4
		false
	end

	def has_flush?
		target_suit = @cards.first.suit
		return true if @cards.all? { |card| card.suit == target_suit }
		false
	end

	def has_straight?
		card_vals = []
		@cards.each { |card| card_vals << card.value }
		card_vals.push(14) if card_vals.include?(1)
		current_streak = 1
		card_vals.sort!.each_index do |i|
			break if i == card_vals.count - 1
			if card_vals[i] == card_vals[i+1] - 1
				current_streak += 1
			else
				current_streak = 1
			end
			return true if current_streak == 5
		end
		false
	end

	def has_three_of_a_kind?
		return true if get_pairs.uniq.count == get_pairs.count - 2
		false
	end

	def has_two_pair?
		return true if get_pairs.uniq.count >= 2
		false
	end

	def has_pair?
		return true unless get_pairs.empty?
		false
	end

	def high_card
		high_value = 0
		@cards.each do |card|
			return 14 if card.name == 'A'
			high_value = card_value if card.value > high_value
		end
		high_value
	end

	def get_pairs
		pairs_array = []
		@cards.each_with_index do |el1, i|
			@cards.each_with_index do |el2, j|
				next if j <= i
				pairs_array << [el1.value, el2.value] if el1.value == el2.value
			end
		end
		pairs_array
	end

end

def has_straight?(card_vals)
	# card_vals = []
	# @cards.each { |card| card_vals << card.value }
	card_vals.push(14) if card_vals.include?(1)
	p card_vals
	current_streak = 1
	card_vals.sort!.each_index do |i|
		p "index is #{i}"
		p "current_streak is #{current_streak}"
		break if i == card_vals.count - 1
		if card_vals[i] == card_vals[i+1] - 1
			current_streak += 1
		else
			current_streak = 1
		end
		return true if current_streak == 5
	end
	false
end




