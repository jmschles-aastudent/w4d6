class Array
  def my_each
    for i in self
      yield i
    end
    self
  end

  def my_map
    accumulator = []
    for i in self
      accumulator << (yield i)
    end
    accumulator
  end

  def my_map2
    accumulator = []
    self.my_each { |i| accumulator << (yield i) }
    accumulator
  end

  def my_select
    accumulator = []
    for i in self
      accumulator << i if (yield i)
    end
    accumulator
  end

  def my_select2
    accumulator = []
    self.my_each { |i| accumulator << i if yield i }
    accumulator
  end

  def my_inject(a = self.first)
    self[1..-1].my_each do |y|
      a = (yield(a, y))
    end
    a
  end

  def my_sort!(&block)
    sorted = false

    until sorted
      sorted = true
      index = 0
      self.my_each do |element|
        break if index + 1 == self.length
        if block.call(self[index], self[index+1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = false
        end
        index += 1
      end
    end
    self
  end

  def my_sort(&block)
    sorted = false
    output = self.dup
    until sorted
      sorted = true
      index = 0
      output.my_map do |element|
        break if index + 1 == output.length
        if block.call(output[index], output[index+1]) == 1
          output[index], output[index + 1] = output[index + 1], output[index]
          sorted = false
        end
        index += 1
      end
    end
    output
  end

end

def block_taker(*args, &block)
  if !block_given?
    puts "NO BLOCK GIVEN!"
  else
    output = args.map {|x| block.call(x)}
  end
  output
end



