def is_prime?(n)
	return false if n < 2
	(2...n).all? { |x| n % x != 0 }
end

def primes(n)
	primes = []
	i = 0
	until primes.count == n
		primes << i if is_prime?(i)
		i += 1
	end
	primes
end

def factorials_rec(n)
	return [1] if n == 1

	rest_facs = factorials_rec(n - 1)
	rest_facs + [rest_facs.last * n]
end

class Array
	def dups
		dups_hash = Hash.new

		self.each_with_index do |el, i|
			dups_hash.has_key?(el) ? dups_hash[el] << i : dups_hash[el] = [i]
		end

		dups_hash.select { |k, v| v.length > 1 }
	end

	def bubble_sort(&blk)
		self.dup.bubble_sort!(&blk)
	end

	def bubble_sort!(&blk)

		blk = Proc.new { |x, y| x <=> y } unless blk

		sorted = false
		until sorted
			sorted = true

			self.each_index do |i|
				break if i == self.length - 1

				if blk.call(self[i], self[i + 1]) == 1
					self[i], self[i+1] = self[i+1], self[i]
					sorted = false
				end
			end
		end
		self
	end
end

class String
	def symmetric_substrings
		sym_strings = []
		self.split("").each_index do |i|
			j = i + 1
			until j >= self.length
				candidate = self[i..j]
				sym_strings << candidate if candidate == candidate.reverse
				j += 1
			end
		end
		sym_strings
	end
end