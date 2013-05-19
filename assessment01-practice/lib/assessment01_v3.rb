def is_prime?(n)
	return false if n < 2
	(2...n).none? { |divisor| n % divisor == 0 }
end

def primes(n)
	primes = []
	i = 2
	until primes.count == n
		primes << i if is_prime?(i)
		i += 1
	end
	primes
end

def factorials_rec(n)
	return [1] if n == 1

	rest_fac = factorials_rec(n-1)
	rest_fac + [rest_fac.last * n]
end

class Array
	def dups
		dups_hash = {}

		each_with_index do |el, i|
			dups_hash.has_key?(el) ? dups_hash[el] << i : dups_hash[el] = [i]
		end

		dups_hash.select { |k, v| v.count > 1 }
	end

	def bubble_sort(&blk)
		dup.bubble_sort!(&blk)
	end

	def bubble_sort!(&blk)
		blk = Proc.new{ |x, y| x <=> y } unless blk

		sorted = false
		until sorted
			sorted = true

			each_index do |i|

				next if i == length - 1

				if blk.call(self[i], self[i+1]) == 1
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
		split("").each_index do |i|
			j = i + 1
			while j < length
				candidate = self[i..j]
				sym_strings << candidate if candidate == candidate.reverse
				j += 1
			end
		end
		sym_strings
	end
end