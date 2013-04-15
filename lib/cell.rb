class Cell

  attr_reader :grid, :row, :pos, :state

  def initialize(grid, row, pos, state)
    @grid, @row, @pos, @state = grid, row, pos, state
  end

  def live?
    state
  end

  def display
    live? ? '0' : ' '
  end

  def next_generation(new_grid)
    new_state = false
    case 
    when (neighbour_count < 2 and live?)
      new_state = false
    when ((2..3).include?(neighbour_count) and live?)
      new_state = true
    when (neighbour_count > 3 and live?)
      new_state = false
    when (neighbour_count == 3 and !live?)
      new_state = true
    end
    Cell.new(new_grid, row, pos, new_state)
  end

  def neighbour_count
    neighbours = []
    neighbours << grid.cells[row - 1][pos - 1] if row > 0 && pos > 0
    neighbours << grid.cells[row - 1][pos] if row > 0
    neighbours << grid.cells[row - 1][pos + 1] if row > 0 && pos < (grid.width - 1)
    neighbours << grid.cells[row][pos - 1] if pos > 0
    neighbours << grid.cells[row][pos + 1] if pos < (grid.width - 1)
    neighbours << grid.cells[row - 1][pos - 1] if row < (grid.height - 1) && pos > 0
    neighbours << grid.cells[row - 1][pos] if row < (grid.height - 1)
    neighbours << grid.cells[row - 1][pos + 1] if (row < grid.height - 1) && (pos < grid.width - 1)
    neighbours.reject { |c| !c.live? }.length
  end

end
