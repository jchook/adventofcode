class Deer
  attr_accessor :current_distance, :points
  def initialize(distance, fly_duration, rest_duration)
    @distance = distance.to_i
    @duration = {fly: fly_duration.to_i, rest: rest_duration.to_i}
    @current_time = @current_distance = @points = 0
    @mode = :fly
  end
  def change_mode
    @mode = (@mode == :fly) ? :rest : :fly
    @current_time = 1
  end
  def fly
    @current_time += 1
    change_mode if @current_time > @duration[@mode]
    @current_distance += @distance if (@mode == :fly)
  end
end

deer = []

ARGF.each do |line|
  deer << Deer.new(*line.match(/(\d+).*?(\d+).*?(\d+)/i).to_a.slice(1..-1))
end

2503.times do 
  deer.each {|d| d.fly }
  deer.max_by(&:current_distance).points += 1
end

p deer.max_by(&:points).points