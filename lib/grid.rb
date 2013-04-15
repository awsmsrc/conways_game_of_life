require './lib/cell.rb'

class Grid

  attr_accessor :cells, :width, :height

  def initialize(width, height)
    @width, @height = width, height
    @cells = [[]]*height
  end

  def self.random(width, height)
    new(width, height).tap do |this|
      height.times do |row|
        width.times do |column|
          this.cells[row][column] = Cell.new(this, row, column, [true, false].sample)
        end
      end
    end
  end

  def next_generation
    new_grid = Grid.new(width, height)
    height.times do |row|
      width.times do |column|
        new_grid.cells[row][column] = cells[row][column].next_generation(new_grid)
      end
    end
    new_grid
  end

  def draw
    cells.each do |row|
      puts row.map(&:display).join('')
    end
  end
end
