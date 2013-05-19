class Hangman

	def initialize
		@guesses = 13
		while true	
			puts "Human guesser (h) or computer guesser (c)?"
			choice = gets.chomp
			if choice == 'h'
				@guesser, @judge = HumanPlayer.new, ComputerPlayer.new
				break
			elsif choice == 'c'
				@guesser, @judge = ComputerPlayer.new, HumanPlayer.new
				break
			else
				puts "Invalid choice, try again!"
			end
		end
	end

	def play
		secret_length = @judge.pick_word

		until @guesses == 0 || won?

			p @judge.status

			p "#{@guesses} guesses left!"

			guess = @guesser.guess_letter(secret_length, @judge.status)

			p guess

			@judge.give_feedback(guess)

			@guesses -= 1

		end

		won? ? puts("WIN!") : puts("FAIL!")

	end

	def won?
		@judge.status.none? { |el| el == '_' }
	end

end

class ComputerPlayer

	def initialize
		@dictionary = generate_dictionary("2of12inf.txt")
		@guessed_letters = []
	end

	def generate_dictionary(filename)
		dictionary = []
		File.readlines(filename).each do |line|
			dictionary << line.chomp.delete('%')
		end
		dictionary
	end

	def status
		unless @status
			@status = []
			@word.length.times { @status << '_' }
		end
		@status
	end

	def get_word_length

	end

	def pick_word
		@word = @dictionary.sample
		@word.length
	end

	def guess_letter(length, status)
		@dictionary.select! { |word| word.length == length }

		possible_words = matching_words(status, @dictionary)

		freq_graph(possible_words)
	end

	def give_feedback(letter)
		if @word.include?(letter)
			@status.each_index do |i|
				@status[i] = letter if @word[i] == letter
			end
		end

	end

	private

	def matching_words(status, candidates)
		regex_string = ""
		status.each do |space|
			space == '_' ? regex_string << '.' : regex_string << space
		end
		regex = /#{regex_string}/
		candidates.select { |word| word =~ regex }
	end

	def freq_graph(candidates)
		freq_graph = Hash.new
		candidates.each do |word|
			word.split("").each do |l|
				freq_graph.has_key?(l) ? freq_graph[l] += 1 : freq_graph[l] = 1
			end
		end
		freq_graph.delete_if { |k, v| @guessed_letters.include?(k) }
		p freq_graph
		# returns the letter with the highest count
		guess = freq_graph.key(freq_graph.values.sort.last)
		@guessed_letters << guess
		guess
	end

end


class HumanPlayer

	def pick_word
		puts "Enter the length of your word."
		@length = gets.chomp.to_i
	end

	def status
		unless @status
			@status = []
			@length.times { @status << '_' }
		end
		@status
	end

	def guess_letter(length, status)
		puts "Guess a letter: "
		gets.chomp
	end

	def give_feedback(letter)
		puts "Any correct indices?"
		gets.chomp.split(" ").each do |el|
			@status[el.to_i] = letter
		end
	end

end