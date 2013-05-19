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

	def adjacent_words(word)
		adjacent_words = []

		right_length_words = @dictionary.select do |wd|
			wd.length == word.length
		end

		right_length_words.each do |candidate|
			if (word.split("") & candidate.split("")).length == word.length - 1
				adjacent_words << candidate
			end 
		end

		adjacent_words
	end

end
