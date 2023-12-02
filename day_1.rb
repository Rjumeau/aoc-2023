# INTS = {
#   "one" => 1,
#   "two" => 2,
#   "three" => 3,
#   "four" => 4,
#   "five" => 5,
#   "six" => 6,
#   "seven" => 7,
#   "eight" => 8,
#   "nine" => 9
# }

# REGEX = /(?:\d+|one|two|three|four|five|six|seven|eight|nine)/

# # p "xeightwone3four"
# # p "xeightwo3four".scan(REGEX)

# # File.open('./inputs/input_1.txt')
 DATA = File.open('./inputs/input_1.txt')
# data = file.readlines.map(&:chomp)
# sum = data.sum do |el|
#   p el
#   ints_arr = el.scan(REGEX).map do |num|
#     INTS.key?(num) ? INTS[num] : num.to_i
#   end.join
#   p ints_arr
#   if ints_arr.length > 1
#     full_digit = "#{ints_arr[0]}#{ints_arr[-1]}".to_i
#   else
#     full_digit = ints_arr[0].to_i
#   end
#   # p full_digit
# end
# sum

WORD_TO_DIGIT = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9",
  "1" => "1",
  "2" => "2",
  "3" => "3",
  "4" => "4",
  "5" => "5",
  "6" => "6",
  "7" => "7",
  "8" => "8",
  "9" => "9",
  "0" => "0",
}

words = WORD_TO_DIGIT.keys
r_words = words.map(&:reverse)

result = DATA.readlines.map do |line|
  digits = line.match(/(#{words.join("|")})/, 0)
  first = WORD_TO_DIGIT[digits[0]]

  digits = line.reverse.match(/(#{r_words.join("|")})/, 0)
  last = WORD_TO_DIGIT[digits[0].reverse]
  (first + last).to_i
end.sum
p result
