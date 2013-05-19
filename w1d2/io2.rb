#!/usr/bin/env ruby

def evaluate_string(str)

  calc = RPNCalculator.new
  tokens = calc.tokens(str)

  tokens.each do |token|
    if token.is_a?(Fixnum)
      calc.stack.push(token)
    else
      operator_parse(token, calc)
    end
  end

  puts calc.stack

end


def operator_parse(token, calc)
  if token == :+
    calc.plus
  elsif token == :-
    calc.minus
  elsif token == :*
    calc.times
  elsif token == :/
    calc.divide
  end
end

class RPNCalculator

  attr_accessor :stack

  def initialize
    @stack = []
  end

  def push(object)
    @stack << object
  end

  def plus
    error if @stack.empty?
    @stack.push(@stack.pop + @stack.pop)
  end

  def minus
    error if @stack.empty?
    first = @stack.pop
    second = @stack.pop
    @stack.push(second - first)
  end

  def divide
    error if @stack.empty?
    first = @stack.pop
    second = @stack.pop
    @stack.push(second / first.to_f)
  end

  def times
    error if @stack.empty?
    @stack.push(@stack.pop * @stack.pop)
  end

  def value
    @stack[-1]
  end

  def error
    raise "calculator is empty"
  end

  def tokens(str)
    tokens = str.split(" ")
    tokens.map do |token|
      if token == "*" || token == "/" || token == "+" || token == "-"
        token.to_sym
      else
        token.to_i
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Enter string or read from file? Type 'string' or 'file'."
  choice = gets.chomp
  if choice == 'file'
    puts "Enter filename: "
    filename = gets.chomp
    calc_str = File.open(filename) { |f| f.readline }.chomp
    evaluate_string(calc_str)
  elsif choice == 'string'
    puts "Enter string: "
    calc_str = gets.chomp
    evaluate_string(calc_str)
  else
    puts "Invalid choice, try again later"
  end
end