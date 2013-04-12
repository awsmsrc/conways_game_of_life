require './lib/cell.rb'

class Grid

  attr_accessor :cells, :width, :height

  def initialize(width, height, random=false)
    @width, @height, @random = width, height, random
    @cells = [].tap { |arr| height.times { arr << ([nil] * width) } }

    if random
      height.times do |row|
        width.times do |column|
          @cells[row][column] = Cell.new(self, row, column, [true, false].sample)
        end
      end
    end
  end

  def draw
    puts "\e[H\e[2J" unless @random
    @cells.each do |row|
      output = ''
      row.each do |cell|
        output += cell.live? ? '0' : ' '
      end
      puts output
    end
  end
end
