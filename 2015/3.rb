# --- Day 3: Perfectly Spherical Houses in a Vacuum ---
# 
# Santa is delivering presents to an infinite two-dimensional grid of houses.
# 
# He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.
# 
# However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?
# 
# For example:
# 
# > delivers presents to 2 houses: one at the starting location, and one to the east.
# ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
# ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
#
directions = ARGF.first.split ''
houses = {}

x = 0
y = 0

def deliver_present(houses,x,y)
  index = x.to_s + ',' + y.to_s 
  houses[index] = houses[index].nil? ? 1 : houses[index] + 1;
end

# "He begins by delivering a present to the house at his starting location"
deliver_present(houses,x,y)

# Go where drunk elf says to go
directions.each do |direction|
  case direction
  when '>'
    x += 1
  when '<'
    x -= 1
  when '^'
    y += 1
  when 'v'
    y -= 1
  end
  deliver_present(houses,x,y)
end
puts "YEAR 1"
puts houses.length.to_s + ' houses received at least one present'


# --- Part Two ---
# 
# The next year, to speed up the process, Santa creates a robot version of himself, Robo-Santa, to deliver presents with him.
# 
# Santa and Robo-Santa start at the same location (delivering two presents to the same starting house), then take turns moving based on instructions from the elf, who is eggnoggedly reading from the same script as the previous year.
# 
# This year, how many houses receive at least one present?
# 
# For example:
# 
# ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
# ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
# ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.
# 
houses = {}

# Santa and Robo-Santa
coordinates = [[0,0],[0,0]]

# "Santa and Robo-Santa start at the same location (delivering two presents to the same starting house)"
deliver_present(houses,coordinates[0][0],coordinates[0][1])
deliver_present(houses,coordinates[1][0],coordinates[1][1])

# Go where drunk elf says to go
index = 0
directions.each do |direction|
  turn = index % 2
  case direction
  when '>'
    coordinates[turn][0] += 1
  when '<'
    coordinates[turn][0] -= 1
  when '^'
    coordinates[turn][1] += 1
  when 'v'
    coordinates[turn][1] -= 1
  end
  deliver_present(houses,coordinates[turn][0],coordinates[turn][1])
  index += 1
end
puts "YEAR 2"
puts houses.length.to_s + ' houses received at least one present'
