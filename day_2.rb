# require "byebug"

file = File.open("./inputs/input_2.txt")
# GAMES_LIST = {}
# limit_bag = { "red" => 12, "green" => 13, "blue" => 14 }

# def games_combinations(game)
#   game_key = game.match(/Game (?<game_id>\d+):/)[:game_id]
#   combinations = game.gsub(/Game \d+:/, "").split(";").flat_map(&:strip)
#   game_combinations = combinations.map do |combination|
#     combination.scan(/\s*(\d+)\s+(\w+)/).to_h.transform_keys(&:to_i).invert
#   end
#   GAMES_LIST[game_key.to_i] = game_combinations
# end


# def valid_games(games_list, limit_bag)
#   games_list.select do |game, combinations|
#     combinations.all? do |combination|
#       combination.all? {|color, count| count <= limit_bag[color]}
#     end
#   end
# end

# # Part 2
# def get_max_colors_count(game, combinations, sum)
#   new_bag = {}
#   combinations.each do |combination|
#     combination.each do |color, count|
#       new_bag[color] ||= 0
#       new_bag[color] = [new_bag[color], count].max
#     end
#   end
#   p new_bag
#   new_bag.values.inject(:*)
# end

# file.readlines.map(&:chomp).each do |game|
#   games_combinations(game)
# end

# sum = 0
# GAMES_LIST.each do |game, combinations|
#   sum += get_max_colors_count(game, combinations, sum)
# end
# valid_games(GAMES_LIST, limit_bag).keys.sum
# p sum
# # count = games_list.select do |_, game|
# #   p game
# #   game.all? do |key, value|
# #     value <= LIMIT_BAG[key]
# #   end
# #   #game[1].all {|key, value| value <= LIMIT_BAG[key] }
# #   # game.select {|key, value| value <= LIMIT_BAG[key] }
# # end
# # p count.sum {|k, _| k }

class Game
  attr_reader :id, :rounds

  def self.parse(line)
    first, *last = line.chomp.split(/[:;]/)
    id = first.split.last.to_i
    rounds = last.map do |str_round|
      str_round.split(',').map do |str_card|
        count, color = str_card.split
        [color.to_sym, count.to_i]
      end.to_h
    end

    new(id, rounds)
  end

  def initialize(id, rounds)
    @id = id
    @rounds = rounds
  end

  def max_cubes
    rounds
      .each_with_object({
        red: 0,
        blue: 0,
        green: 0
      }) do |round, counts|
        round.each do |color, count|
          counts[color] = count if count > counts[color]
        end
      end
  end

  def max_power
    max_cubes.values.inject(:*)
  end

  def possible?
    max_cubes in {
      red: ..12,
      green: ..13,
      blue: ..14,
    }
  end
end



data = file.each_line

r = data.map do |line|
  g = Game.parse(line)
  g.max_power
  # p line
  # p g.max_cubes
  # p g.max_power
  # if g.possible?
  #   g.id
  # else
  #   0
  # end
end
p r.sum
