require './lib/grid.rb'

class Game
  def initialize(width, height)
    grid = Grid.random(width, height)
    generation = 0
    while true
      grid.draw
      puts generation += 1
      sleep 1
      puts "\e[H\e[2J"
      grid = grid.next_generation
    end
  end
end
