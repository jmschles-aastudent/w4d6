#!/usr/bin/env ruby
# require 'debugger'

class TicTacToe

	def initialize
		@board = make_board
		@players = set_players
	end

	def play
		# debugger
		alternator = 0
		puts "Game started!"
		until won?
			render
			puts "Player #{alternator % 2 + 1}'s turn"
			@players[alternator%2].move(@board, "#{alternator % 2 + 1}")
			alternator += 1
		end
		alternator += 1
		render
		puts "Player #{alternator % 2 + 1} wins!"
	end
	
	def won?
		rows_check || cols_check || diags_check
	end

	def set_players
		players = []
		until players.count == 2
			puts "New player: human (h) or computer (c)?"
			choice = gets.chomp
			if choice == 'h'
				players << HumanPlayer.new
			elsif choice == 'c'
				players << ComputerPlayer.new
			else
				puts "Bad input, try again"
			end
		end
		players
	end	

	private

	def rows_check
		@board.each do |row|
			return true if ttt_checker(row)
		end
		false
	end	

	def cols_check
		flat_board = @board.flatten
		col1 = flat_board.values_at(0, 3, 6)
		col2 = flat_board.values_at(1, 4, 7)
		col3 = flat_board.values_at(2, 5, 8)
		return true if ttt_checker(col1) || ttt_checker(col2) || ttt_checker(col3)
		false
	end

	def diags_check
		flat_board = @board.flatten
		diag1 = flat_board.values_at(0, 4, 8)
		diag2 = flat_board.values_at(2, 4, 6)
		return true if ttt_checker(diag1) || ttt_checker(diag2)
		false
	end

	def ttt_checker(trio)
		return true if trio.join == '111' || trio.join == '222'
		false
	end

	def make_board
		board = []
		3.times { board << [] }
		board.each do |row|
			3.times { row << nil }
		end
		board
	end

	def render
		p @board[0]
		p @board[1]
		p @board[2]
	end
end

class HumanPlayer

	def initialize
	end

	def move(board, mark)
		puts "Pick a square to move to (0-2 = row 1, 3-5 = row 2, 6-8 = row 3):"
		moved = false
		until moved
			choice = gets.chomp.to_i
			if board[choice/3][choice%3].nil?
				board[choice/3][choice%3] = mark
				moved = true
			else
				puts "Invalid move, try again"
			end
		end
	end

end

class ComputerPlayer

	def initialize
	end

	def move(board, mark)
		moved = false
		until moved
			target_row = rand(3) - 1
			target_col = rand(3) - 1
			if board[target_row][target_col].nil?
				board[target_row][target_col] = mark
				moved = true
			end
		end
	end

end

if __FILE__ == $PROGRAM_NAME
	game = TicTacToe.new
	game.play
end