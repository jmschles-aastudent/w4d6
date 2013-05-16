def range(start, ending, accumulator = [])
  accumulator << start
  if start == ending
    return accumulator
  else
    range(start + 1, ending, accumulator)
  end
end

def array_sum_recursive(array, index = 0, sum = 0)
  sum += array[index]
  if index == array.length - 1
    return sum
  else
    index += 1
    array_sum_recursive(array, index, sum)
  end
end

def array_sum_iterative(array)
  array.inject(:+)
end

def exponent1(b, n)
  if n == 0
    return 1
  else
    b * exponent1(b, n - 1)
  end
end

def exponent2(b, n)
  if n == 0
    return 1
  else
    if n % 2 == 0
      exponent2(b, n/2) ** 2
    else
      b * (exponent2(b, (n - 1)/2) ** 2)
    end
  end
end

def deep_dup(argument)
  if !argument.is_a?(Array)
    return argument
  else
    new_array = []
    argument.each do |element|
      new_array << deep_dup(element)
    end
    return new_array
  end
end

def n_fibs(num)
  accumulator = []
  (0...num).each do |x|
    accumulator << fib(x)
  end
  accumulator
end

def fib(n)
  if n == 0
    return 0
  elsif n == 1
    return 1
  elsif n == 2
    return 1
  else
    return fib(n-2) + fib(n-1)
  end
end

def bsearch(array, target)
  middle = array.length / 2
  if array[middle] == target
    return middle
  elsif array.length == 1
    return nil
  else
    if array[middle] < target
      return_value = bsearch(array[middle..-1], target)
      return_value ? middle + return_value : nil
    else
      bsearch(array[0...middle], target)
    end
  end
end


# def reduce(number, divisor)
#   subtractions = 0
#   until number < divisor
#     accumulator << number / divisor
#     number /= divisor
#   end
#   accumulator
# end


# def make_change(amount, denominations)
#   p "amount is #{amount}"
#   p "accumulator is #{accumulator}"
#   p "denominations is #{denominations.inspect}"
#   denominations.sort!.reverse!
#   if amount == 0
#     return accumulator
#   else
#     accumulator << amount / denominations[0]
#     make_change(amount % denominations[0], accumulator, denominations[1..-1])
#   end
# end

def reduce(amount, denominations)
  denominations.sort!.reverse!
  accumulator = []
  (denominations.length).times do |index|
    (amount / denominations[index]).times {accumulator << denominations[index]}
    amount %= denominations[index]
  end
  accumulator
end

def make_change(amount, denominations, accumulator = [])
  if denominations.count == 0
    shortest_array = accumulator.first
    accumulator.each do |sub_array|
      if sub_array.count < shortest_array.count
        shortest_array = sub_array
      end
    end
    return shortest_array
  else
    accumulator << reduce(amount, denominations)
    make_change(amount, denominations[1..-1], accumulator)
  end
end

# def merge_sort(array, accumulator = [])
#   if array.count < 2
#     return array
#   else
#     exploded_array = explode_array(array)
#     paired_arrays = pair_up(exploded_array)
#     leftmost_element = paired_arrays.first.shift
#     case leftmost_element <=> paired_arrays[1].first
#     when -1
#       accumulator << leftmost_element
#     else
#       accumulator << paired_arrays[1].shift
#     end
#   end
# end
#
# def explode_array(array)
#   array.map { |sub_array| [sub_array] }
# end
#
# def pair_up(exploded_array)
#   i = 0
#   accumulator = []
#   while i < exploded_array.length
#     accumulator << exploded_array[i..i+1].flatten
#     i += 2
#   end
#   accumulator
# end

def merge_sort(array)
  if array.length < 2
    return array
  else
    middle = array.length / 2
    sorted_merge(merge_sort(array[0...middle]), merge_sort(array[middle..-1]))
  end
end

def sorted_merge(array1, array2)
  new_array = []
  until array1.empty? || array2.empty?
    if array1.first < array2.first
      new_array << array1.shift
    else
      new_array << array2.shift
    end
  end
  new_array += array1
  new_array += array2
end

def subsets(array, accumulator = [])
  if array.length == 1
    accumulator << array
    accumulator.uniq
  else
    array.each_index do |index|
      accumulator << array[index..-1]
      accumulator << array[0..index]
      accumulator << [array[index], array[-1]] unless array[index] == array[-1]
      accumulator << [array[0], array[index]] unless array[0] == array[index]
    end
    subsets(array[1..-1], accumulator)
  end
end



def word_chains(start, target)
dictionary = File.readlines("2of12inf.txt")
alphabet = ("a".."z").to_a
  if start == target
    return target
    File.close
  else
    start.split("").each_with_index do |letter, index|
      (1..26).to_a.each do
        letter = alphabet[(alphabet.index(letter) + 1) % 26]
        start[index] = letter
        p "start is #{start}"
        break if dictionary.include?(start+"\r\n")
      end
      p "after the break, start is #{start}"

    end
      word_chains(start, target)
    # word_chains(start, target)
  end
end

p word_chains("duck", "ruby")