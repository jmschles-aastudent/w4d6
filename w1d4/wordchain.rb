class WordChainer

	attr_reader :dictionary

	def initialize
		@dictionary = generate_dictionary('2of12inf.txt')
	end

	def generate_dictionary(filename)
		dictionary = []
		File.readlines(filename).each do |line|
			dictionary << line.chomp.delete('%')
		end
		dictionary
	end

	def adjacent_words(word, candidates)
		adjacent_words = []

		word.split("").each_index do |i|
			('a'..'z').each do |letter|
				attempt = word.dup
				attempt[i] = letter
				adjacent_words << attempt if candidates.include?(attempt) unless attempt == word
			end
		end

		adjacent_words
	end

	def find_chain(start, target)

		candidates = @dictionary.select { |word| word.length == start.length }

		current_words = [start]
		new_words = []
		visited_words = { start => nil }

		until visited_words.has_key?(target) || current_words.empty?

			current_words.each do |word|
				p word
				words_to_add = adjacent_words(word, candidates)

				words_to_add.each do |addition|
					new_words << addition unless visited_words.has_key?(addition)
				end

				p new_words

				new_words.each do |new_word| 
					visited_words[new_word] = word unless visited_words.has_key?(new_word)
				end

				p visited_words
			end

			candidates -= current_words
			current_words = new_words

		end

		puts build_chain(visited_words, target)
		target
	end

	def build_chain(visited_words, target)
		reverse_chain = [target]
		until visited_words[target] == nil
			reverse_chain << visited_words[target]
			target = visited_words[target]
		end
		reverse_chain.reverse
	end


end
