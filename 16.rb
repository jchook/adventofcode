# --- Day 16: Aunt Sue ---
#
# Your Aunt Sue has given you a wonderful gift, and you'd like to send her a thank you card. However, there's a small problem: she signed it "From, Aunt Sue".
# 
# You have 500 Aunts named "Sue".
# 
# So, to avoid sending the card to the wrong person, you need to figure out which Aunt Sue (which you conveniently number 1 to 500, for sanity) gave you the gift. You open the present and, as luck would have it, good ol' Aunt Sue got you a My First Crime Scene Analysis Machine! Just what you wanted. Or needed, as the case may be.
# 
# The My First Crime Scene Analysis Machine (MFCSAM for short) can detect a few specific compounds in a given sample, as well as how many distinct kinds of those compounds there are. According to the instructions, these are what the MFCSAM can detect:
# 
# children, by human DNA age analysis.
# cats. It doesn't differentiate individual breeds.
# Several seemingly random breeds of dog: samoyeds, pomeranians, akitas, and vizslas.
# goldfish. No other kinds of fish.
# trees, all in one group.
# cars, presumably by exhaust or gasoline or something.
# perfumes, which is handy, since many of your Aunts Sue wear a few kinds.
# In fact, many of your Aunts Sue have many of these. You put the wrapping from the gift into the MFCSAM. It beeps inquisitively at you a few times and then prints out a message on ticker tape:
# 
# children: 3
# cats: 7
# samoyeds: 2
# pomeranians: 3
# akitas: 0
# vizslas: 0
# goldfish: 5
# trees: 3
# cars: 2
# perfumes: 1
#
# You make a list of the things you can remember about each Aunt Sue. Things missing from your list aren't zero - you simply don't remember the value.
# 
# What is the number of the Sue that got you the gift?
# 
#

# Part 1:
#
# data = [[:children, 3],[:cats, 7],[:samoyeds, 2],[:pomeranians, 3],[:akitas, 0],[:vizslas, 0],[:goldfish, 5],[:trees, 3],[:cars, 2],[:perfumes, 1]]
# 
# ARGF.each do |line|
#   p line if (line.scan(/([a-z]+):\s(\d+)/).map{ |match| [match[0].to_sym, match[1].to_i] } & data).length == 3
# end

# Part 2:
#
data = { children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1 }
comp = { cats: :>, trees: :>, pomeranians: :<, goldfish: :< }
ARGF.each do |line|
  input = line.scan(/([a-z]+):\s(\d+)/).map{|m| [m.first.to_sym, m.last.to_i]}
  p line if input.delete_if{|m| ! m.last.send(comp[m.first] || :==, data[m.first])}.length == 3
end