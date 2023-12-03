require 'set'

file_path = './inputs/input_3.txt'
file_content = File.read(file_path)

array = file_content.split("\n")

def recompose_number(string, start_index, direction)
  number_forward = recompose_forward(string, start_index)
  number_backward = recompose_backward(string, start_index)

  # If both numbers are nil, return nil
  return nil if number_forward.nil? && number_backward.nil?

  if (direction === "forward")
    return number_forward ? number_forward.to_i : nil
  elsif (direction === "backward")
    return number_backward ? number_backward.to_i : nil
  elsif (direction === "both")
    result = ""
    if (number_backward)
      result = result + number_backward
    end
    if (number_forward)
      result = result + number_forward[1..-1]
    end
    return result != "" ? result.to_i : nil
  end
end

def recompose_forward(string, start_index)
  number = ""
  index = start_index

  while index < string.length && string[index] =~ /\d/
    number += string[index]
    index += 1
  end

  return number.empty? ? nil : number
end

def recompose_backward(string, start_index)
  number = ""
  index = start_index

  while index >= 0 && string[index] =~ /\d/
    number += string[index]
    index -= 1
  end

  return number.empty? ? nil : number.reverse
end

gears_ratios = []
gear_positions = []

array.each_with_index do |line, line_index|
  y = line_index

  line.chars.each_with_index do |char, idx|
    if char === '*'
      gear_positions.push([idx, y])
    end
  end
end

gear_positions.each do |position|
  numbers = []

  x = position[0]
  y = position[1]

  line_length = array[y].chars.length - 1
  array_max_line = array.length - 1

  items_to_check = [
    [array[y], x + 1, "forward", false, ""], # droite
    [array[y], x - 1, "backward", false, ""], # gauche
    [array[y - 1], x, "both", false, "up"], # dessus
    [array[y + 1], x, "both", false, "down"], # dessous
    [array[y - 1], x - 1, "backward", true, "up"], # diag haut gauche
    [array[y - 1], x + 1, "forward", true, "up"], # diag haut droite
    [array[y + 1], x - 1, "backward", true, "down"], # diag bas gauche
    [array[y + 1], x + 1, "forward", true, "down"] # diag bas droite
  ]

  i = 0
  found_up = false
  found_down = false

  while numbers.length < 2 && i < items_to_check.length
    string = items_to_check[i].first
    start = items_to_check[i][1]
    direction = items_to_check[i][2]
    is_diag = items_to_check[i][3]
    verticality = items_to_check[i].last
    if start && string && string.length > 1 && direction
      res = recompose_number(string, start, direction)
      if (res != nil)
        if (!is_diag)
          found_down = true if verticality === 'down'
          found_up = true if verticality === 'up'
          numbers.push(res)
        elsif (is_diag && verticality === "up")
          numbers.push(res) if !found_up
        elsif (is_diag && verticality === "down")
          numbers.push(res) if !found_down
        end
      end
    end
    i += 1
  end

  if numbers.length === 2
    gears_ratios.push(numbers[0] * numbers[1])
  end
end

p gears_ratios.sum
