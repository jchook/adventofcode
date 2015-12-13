pairs = {}
people = []
arrangement_values = []

ARGF.each do |line|
  _, a, _, amt, b = line.chomp.sub('lose ', '-').match(/([A-Za-z]+) would (gain )?(\-?[0-9]+) happiness units by sitting next to ([A-Za-z]+)\./).to_a
  people << a unless people.include? a
  people << b unless people.include? b
  pairs[[people.index(a), people.index(b)]] = amt.to_i
end

p people
p pairs

people.each_index.to_a.permutation(people.length) do |p|
  arrangement_values << ([p[-1]] + p + p.reverse[1..-1] + [p[-1]]).each_cons(2).reduce(0){ |sum, pair| sum + pairs[pair] }
end

p arrangement_values.max