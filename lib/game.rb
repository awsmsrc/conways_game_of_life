require './lib/grid.rb'

class Game
  def initialize(width, height)
    @grid = Grid.new(width, height, true)
    @generation = 0
    puts "\e[H\e[2J"
  end

  def run
    while true
      @grid.draw
      puts @generation += 1
      tick
      sleep 1
    end
  end

  private

  def tick
    new_grid = Grid.new(@grid.width, @grid.height)
    @grid.height.times do |row|
      @grid.width.times do |column|
        new_grid.cells[row][column] = @grid.cells[row][column].next_generation
      end
    end
    @grid = new_grid
  end
end
