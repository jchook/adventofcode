# --- Day 6: Probably a Fire Hazard ---
# 
# Because your neighbors keep defeating you in the holiday house decorating contest year after year, you've decided to deploy one million lights in a 1000x1000 grid.
# 
# Furthermore, because you've been especially nice this year, Santa has mailed you instructions on how to display the ideal lighting configuration.
# 
# Lights in your grid are numbered from 0 to 999 in each direction; the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include whether to turn on, turn off, or toggle various inclusive ranges given as coordinate pairs. Each coordinate pair represents opposite corners of a rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers to 9 lights in a 3x3 square. The lights all start turned off.
# 
# To defeat your neighbors this year, all you have to do is set up your lights by doing the instructions Santa sent you in order.
# 
# For example:
# 
# turn on 0,0 through 999,999 would turn on (or leave on) every light.
# toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
# turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
# After following the instructions, how many lights are lit?
# 
# Your puzzle answer was 569999.
# 
# The first half of this puzzle is complete! It provides one gold star: *
# 
# --- Part Two ---
# 
# You just finish implementing your winning light pattern when you realize you mistranslated Santa's message from Ancient Nordic Elvish.
# 
# The light grid you bought actually has individual brightness controls; each light can have a brightness of zero or more. The lights all start at zero.
# 
# The phrase turn on actually means that you should increase the brightness of those lights by 1.
# 
# The phrase turn off actually means that you should decrease the brightness of those lights by 1, to a minimum of zero.
# 
# The phrase toggle actually means that you should increase the brightness of those lights by 2.
# 
# What is the total brightness of all lights combined after following Santa's instructions?
# 
# For example:
# 
# turn on 0,0 through 0,0 would increase the total brightness by 1.
# toggle 0,0 through 999,999 would increase the total brightness by 2000000.
#
class Canvas
  def initialize(w, h)
    @width = w
    @height = h
    @canvas = Array.new(w*h)
  end
  def length
    @canvas.compact.length
  end
  def draw_point(x,y,behavior='toggle')
    index = @width * y + x
    case behavior
    when 'toggle'
      @canvas[index] = @canvas[index].nil? ? true : nil
    when 'turn on'
      @canvas[index] = true
    when 'turn off'
      @canvas[index] = nil
    end
  end
  def draw_rect(x1,y1,x2,y2,behavior)
    (x1..x2).each do |x|
      (y1..y2).each do |y|
        draw_point(x,y,behavior)
      end
    end
  end
end

class BrightnessCanvas < Canvas
  def initialize(w, h)
    @width = w
    @height = h
    @canvas = Array.new(w*h, 0)
  end
  def length
    @canvas.inject :+
  end
  def draw_point(x,y,behavior='toggle')
    index = @width * y + x
    case behavior
    when 'toggle'
      @canvas[index] += 2
    when 'turn on'
      @canvas[index] += 1
    when 'turn off'
      @canvas[index] = [0, @canvas[index] - 1].max
    end
  end
end

c = BrightnessCanvas.new(1000,1000)

ARGF.each do |instruction|
  matches = /^(toggle|turn off|turn on) ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)$/.match(instruction)
  c.draw_rect(matches[2].to_i, matches[3].to_i, matches[4].to_i, matches[5].to_i, matches[1])
end

puts c.length