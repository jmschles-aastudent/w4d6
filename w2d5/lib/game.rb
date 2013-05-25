require './card'
require './player'
require './hand'

class Game

	HAND_VALUES = {
		9 => "Straight Flush",
		8 => "Four of a Kind",
		7 => "Full House",
		6 => "Flush",
		5 => "Straight",
		4 => "Three of a Kind",
		3 => "Two Pair",
		2 => "Pair",
		1 => "High card"
	}

	def initialize(num_players)
		@players = []
		num_players.times do |i|
			@players << Player.new("Player #{i+1}", 100)
		end
	end

	def run
		while true
			@pot = 0
			@current_players = @players.dup
			deal
			print_hands



		end
	end

	def deal
		@deck = Deck.new
		@deck.shuffle
		
		5.times do
			@current_players.each do |player|
				player.hand << @deck.pop
			end
		end
	end

	def handle_discard(player)
		discards = player.discard
		num_discards = discards.count
		discards.each { |index| player.hand.delete_at(index) }
		num_discards.times { player.hand << @deck.pop }
		return
	end

	def handle_action(player)
		action = player.make_play
		action_keyword = action.first
		case action_keyword
		when 'F'
			puts "#{player.name} folds."
			@current_players -= [player]
		when 'C'
			puts "#{player.name} checks."
		when 'B'
			bet_amount = action.last.to_i
			puts "#{player.name} bets #{bet_amount}."
			player.stack -= bet_amount
			@pot += bet_amount
		end

	end

	def print_hands
		@current_players.each do |player|
			print "#{player.name}'s hand: "
			print "#{player.hand}\n"
		end
	end

end