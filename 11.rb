# --- Day 11: Corporate Policy ---
# 
# Santa's previous password expired, and he needs help choosing a new one.
# 
# To help him remember his new password after the old one expires, Santa has devised a method of coming up with a password based on the previous one. Corporate policy dictates that passwords must be exactly eight lowercase letters (for security reasons), so he finds his new password by incrementing his old password string repeatedly until it is valid.
# 
# Incrementing is just like counting with numbers: xx, xy, xz, ya, yb, and so on. Increase the rightmost letter one step; if it was z, it wraps around to a, and repeat with the next letter to the left until one doesn't wrap around.
# 
# Unfortunately for Santa, a new Security-Elf recently started, and he has imposed some additional password requirements:
# 
# Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
# Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
# Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
# For example:
# 
# hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
# abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
# abbcegjk fails the third requirement, because it only has one double letter (bb).
# The next password after abcdefgh is abcdffaa.
# The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.
# Given Santa's current password (your puzzle input), what should his next password be?
# 
# Your puzzle input is hxbxwxba.
#
# --- Part Two ---
# 
# Santa's password expired again. What's the next one?
# 
# Your puzzle answer was hxcaabcc.
# ALPHA = ('a'..'z').zip((0..25)).to_h
# 
class Array
  def include_series?(ary)
    for start in (0..(self.length - ary.length))
      return true if self.slice(start, ary.length) == ary
    end
    nil
  end
end

def next_valid_password(password)
  loop { break if valid?(password = skip_invalid_password(increment_password(password))) }
  password
end

def increment_password(password)
  (password.to_i(36) + 1).to_s(36).gsub('0', 'a')
end

# This makes it super fast by skipping passwords with invalid letters
#
def skip_invalid_password(p)
  if i = p.index(/[iol]/)
    p = p[0..i-1] + increment_password(p[i]) + ('a' * (p.length - i - 1))
  end
  p
end

def rolling_diff(password)
  letters = password.split('')
  letters.map.with_index{ |c, i| i > 0 ? ALPHA[c] - ALPHA[letters[i - 1]] : 0 }
end

def valid?(password)
  (!password.match /[iol]/) && password.match(/(.)\1.*(.)\2/) && rolling_diff(password).include_series?([1,1])
end

puts next_valid_password('hxbxwxba')
puts next_valid_password('hxbxxyzz')