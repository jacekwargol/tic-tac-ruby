class Board
  attr_accessor :board, :test

  def initialize(size)
    @board = Array.new(size)
    @n = size
  end

  def print_board
    @board.each_with_index do |ch, i|
      ch = '_' if !ch
      (i-1) % 3 == 0 ? print('|', ch, '|') : print(ch)
      print("\n") if (i+1) % 3 == 0
    end
  end

  def change_state(cell_num, symbol)
    @board[cell_num] = symbol
  end

  def cells_equal(*cells)
    cells.all? { |cell| cell and (cell == cells[0]) }
  end
end