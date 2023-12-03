require 'set'

file_path = './inputs/input_3.txt'
file_content = File.read(file_path)

array = file_content.split("\n")

symbols = [
  '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
  '-', '_', '=', '+', '[', '{', ']', '}', ';', ':',
  '\'', '"', ',', '<', '>', '/', '?', '|', '\\', '`', '~'
]

numbers_to_sum = []

array.each_with_index do |line, line_index|
  line_copy = line
  previous_line = array[line_index - 1]
  next_line = array[line_index + 1]

  line_numbers = line.scan(/\d+/)
  line_numbers.each do |number|
    values_around = []
    number_index = line_copy =~ /#{Regexp.escape(number)}/

    values_around.push(line_copy[number_index - 1])
    values_around.push(line_copy[number_index + number.length])

    indexes_to_check = [number_index - 1, number_index + number.length]
    number.chars.each_with_index do |n, i|
      indexes_to_check.push(number_index + i)
    end

    if previous_line
      indexes_to_check.each do |idx|
        values_around.push(previous_line[idx])
      end
    end

    if next_line
      indexes_to_check.each do |idx|
        values_around.push(next_line[idx])
      end
    end

    if (values_around & symbols).any?
      numbers_to_sum.push(number.to_i)
    end

    line_copy = line_copy.sub(/#{Regexp.escape(number.to_s)}/, '.' * number.length)
  end
end

p numbers_to_sum.sum
