# --- Day 15: Science for Hungry People ---

# Today, you set out on the task of perfecting your milk-dunking cookie recipe. All you have to do is find the right balance of ingredients.
# 
# Your recipe leaves room for exactly 100 teaspoons of ingredients. You make a list of the remaining ingredients you could use to finish the recipe (your puzzle input) and their properties per teaspoon:
# 
# capacity (how well it helps the cookie absorb milk)
# durability (how well it keeps the cookie intact when full of milk)
# flavor (how tasty it makes the cookie)
# texture (how it improves the feel of the cookie)
# calories (how many calories it adds to the cookie)
# You can only measure ingredients in whole-teaspoon amounts accurately, and you have to be accurate so you can reproduce your results in the future. The total score of a cookie can be found by adding up each of the properties (negative totals become 0) and then multiplying together everything except calories.
# 
# For instance, suppose you have these two ingredients:
# 
# Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
# Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
# Then, choosing to use 44 teaspoons of butterscotch and 56 teaspoons of cinnamon (because the amounts of each ingredient must add up to 100) would result in a cookie with the following properties:
# 
# A capacity of 44*-1 + 56*2 = 68
# A durability of 44*-2 + 56*3 = 80
# A flavor of 44*6 + 56*-2 = 152
# A texture of 44*3 + 56*-1 = 76
# Multiplying these together (68 * 80 * 152 * 76, ignoring calories for now) results in a total score of 62842880, which happens to be the best score possible given these ingredients. If any properties had produced a negative total, it would have instead become zero, causing the whole score to multiply to zero.
# 
# Given the ingredients in your kitchen and their properties, what is the total score of the highest-scoring cookie you can make?
#
require 'matrix'

max = 0
ingredients = []

ARGF.each do |line|
  ingredients.push Vector.[](*line.scan(/-?\d+/).to_a.map{|x| x.to_i })
end

(0..100).each do |i|
  (0..100-i).each do |j|
    (0..100-i-j).each do |k|
      portions = [i, j, k, 100 - i - j - k]
      sums = ingredients.each_index.map{|x| ingredients[x] * portions[x] }.reduce(:+).to_a
      next if sums[-1] != 500 # part 2
      max = [max, sums[0..-2].map{|x| x > 0 ? x : 0 }.reduce(:*)].max
    end
  end
end

p max

# Hardcoding those nested loops is not exactly satisfying.
# Let's generalize it...
#
# class Array
# 
#   def stars_and_bars(balls, &block)
#     @stars_and_bars_block = block
#     stars_and_bars_r(balls, [])
#   end
# 
#   private
# 
#   def stars_and_bars_r(balls, so_far=[])
#     if so_far.length == length - 1
#       @stars_and_bars_block.call so_far + [balls - so_far.reduce(:+)]
#     else
#       (0..balls - (so_far.reduce(:+) || 0)).each do |i|
#         stars_and_bars_r(balls, so_far + [i])
#       end
#     end
#   end
# 
# end
# 
# max = 0
# 
# ingredients.stars_and_bars(100) do |portions|
#   sums = ingredients.each_index.map{|x| ingredients[x] * portions[x] }.reduce(:+).to_a
#   next if sums[-1] != 500 # part 2
#   max = [max, sums[0..-2].map{|x| x > 0 ? x : 0 }.reduce(:*)].max
# end
# 
# p max 