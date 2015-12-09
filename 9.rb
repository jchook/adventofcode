# --- Day 9: All in a Single Night ---
# 
# Every year, Santa manages to deliver all of his presents in a single night.
# 
# This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?
# 
# For example, given the following distances:
# 
# London to Dublin = 464
# London to Belfast = 518
# Dublin to Belfast = 141
# The possible routes are therefore:
# 
# Dublin -> London -> Belfast = 982
# London -> Dublin -> Belfast = 605
# London -> Belfast -> Dublin = 659
# Dublin -> Belfast -> London = 659
# Belfast -> Dublin -> London = 605
# Belfast -> London -> Dublin = 982
# The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.
# 
# What is the distance of the shortest route?
#
# --- Part Two ---
# 
# The next year, just to show off, Santa decides to take the route with the longest distance instead.
# 
# He can still start and end at any two (different) locations he wants, and he still must visit each location exactly once.
# 
# For example, given the distances above, the longest route would be 982 via (for example) Dublin -> London -> Belfast.
# 
# What is the distance of the longest route?
# 
#
class City
  attr_reader :connections, :name, :connection_distances
  def initialize(name)
    @name = name
    @connections = []
    @connection_distances = []
  end
  def add_connection(city, distance)
    @connections.push(city)
    @connection_distances.push(distance)
  end
  def distance_to_city(city)
    index = @connections.index(city)
    index.nil? ? nil : @connection_distances[index]
  end
end

cities = {}
route_distances = []

# Import
ARGF.each do |line|
  matches = line.match(/([A-Za-z]+) to ([A-Za-z]+) = ([0-9]+)/)
  cities[matches[1]] = City.new(matches[1]) if cities[matches[1]].nil?
  cities[matches[2]] = City.new(matches[2]) if cities[matches[2]].nil?
  cities[matches[1]].add_connection(cities[matches[2]], matches[3].to_i)
  cities[matches[2]].add_connection(cities[matches[1]], matches[3].to_i)
end

# Brute force
cities.to_a.permutation(cities.length) do |p|
  total_distance = 0
  from_city = p.shift.last
  route.push(from_city.name)
  loop do
    to_city = p.shift.last
    break if (distance = from_city.distance_to_city(to_city)).nil?
    total_distance += distance
    from_city = to_city
    if p.length == 0
      route_distances.push(total_distance)
      break
    end
  end
end

puts route_distances.min.to_s
puts route_distances.max.to_s