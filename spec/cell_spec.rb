require './lib/cell.rb'

describe Cell do
  context 'with no neighbours'
  let(:grid) { double }
  let(:live_cell) { double }
  let(:dead_cell) { double }
  before do
    grid.stub(:width) { 3 }
    grid.stub(:height) { 3 }
    grid.stub(:cells) do
      [[live_cell,dead_cell,dead_cell],
       [dead_cell,dead_cell,live_cell],
       [live_cell,dead_cell,live_cell]]
    end
    live_cell.stub(:live?) do
      true
    end
    dead_cell.stub(:live?) do
      false
    end
  end

  context 'with a surrounded cell' do
    subject { Cell.new(grid, 1, 1, true) }
    its(:live?) { should be == true }
    its(:neighbour_count) { should be == 3 }
  end

  context 'with a cell on the left edge of the grid' do
    subject { Cell.new(grid, 1, 0, true) }
    its(:live?) { should be == true }
    its(:neighbour_count) { should be == 2 }
  end

  context 'with a cell on the right edge of the grid' do
    subject { Cell.new(grid, 2, 2, true) }
    its(:live?) { should be == true }
    its(:neighbour_count) { should be == 1 }
  end

  describe '#next_generation' do
    context 'with fewer than two live neighbours dies' do
      subject { Cell.new(grid, 0, 2, true) }
      specify { subject.next_generation.live?.should be false }
    end
    context 'with two or three live neighbours lives on' do
      subject { Cell.new(grid, 1, 0, true) }
      specify { subject.next_generation.live?.should be true }
    end
    context 'with more than three live neighbours dies' do
      subject { Cell.new(grid, 1, 2, true) }
      specify { subject.next_generation.live?.should be false }
    end
    context 'a dead cell with exactly three live neighbours becomes a live cell' do
      subject { Cell.new(grid, 2, 1, false) }
      specify { subject.next_generation.live?.should be true }
    end
    context 'a dead cell with exactly two live neighbours does not become a live cell' do
      subject { Cell.new(grid, 1, 0, false) }
      specify { subject.next_generation.live?.should be false }
    end
  end

end
