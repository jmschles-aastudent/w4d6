# def primes(n)
# 	primes_array = []
# 	i = 0
# 	until primes_array.length == n
# 		primes_array << i if is_prime?(i)
# 		i += 1
# 	end
# 	primes_array

# end

# def is_prime?(n)
# 	return false if n < 2
# 	(2...n).each do |divisor|
# 		return false if n % divisor == 0
# 	end
# 	true
# end

# # def factorials_rec(n)
# # 	if n == 1
# # 		ar


# # end

# # def factorials_rec(n)
# # 	if n == 1
# # 		return [1]
# # 	else
# # 		return factorials_rec(n-1) + [factorial(n)]
# # 	end
# # end

# # def factorial(n)
# # 	n == 1 ? 1 : n * factorial(n - 1)
# # end

# class String
# 	def symmetric_substrings
# 		sym_strings = []
# 		i = 0
# 		while i < self.length - 2
# 			j = i + 2
# 			while j < self.length
# 				sym_strings << self[i..j] if (self[i..j]).symmetric?
# 				j += 1
# 			end
# 			i += 1
# 		end
# 		sym_strings
# 	end

# 	def symmetric?
# 		if self.length <= 1
# 			return true
# 		else
# 			return false if self[0] != self[-1]
# 			(self[1..-2]).symmetric?
# 		end
# 	end
# end

class Array
	def dups
		dups_hash = Hash.new([])

		self.each_with_index do |el, i|
			dups_hash[el] += [i]
		end

		dups_hash.delete_if { |k, v| v.length < 2 }
		dups_hash
	end



	def bubble_sort(&blk)
		duped_arr = self.dup
		sorted = false
		until sorted
			sorted = true
			
			duped_arr.each_index do |i|
				break if i == duped_arr.length - 1
				if block_given?
					if blk.call(duped_arr[i], duped_arr[i+1]) == 1
						duped_arr[i], duped_arr[i + 1] = duped_arr[i + 1], duped_arr[i]
						sorted = false
					end
				else
					if duped_arr[i] > duped_arr[i + 1]
						duped_arr[i], duped_arr[i + 1] = duped_arr[i + 1], duped_arr[i]
						sorted = false
					end
				end
			end
		end
		duped_arr
	end
end