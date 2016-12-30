class Board
  attr_accessor :board, :blanks

  def initialize
    @board = Array.new(9)
    @non_empty_cells = []
  end

  def print_board
    @board.each_with_index do |ch, i|
      ch = '_' if !ch
      (i-1) % 3 == 0 ? print('|', ch, '|') : print(ch)
      print("\n") if (i+1) % 3 == 0
    end
  end

  def change_cell(cell_num, symbol)
    if cell_num.between?(0, 8) and !@board[cell_num]
      @board[cell_num] = symbol
    end
    self
  end

  def cells_equal?(*cells)
    cells.all? { |cell| cell and (cell == cells[0]) }
  end

  def find_possible_moves
    moves = []
    @board.each_with_index { |cell, i| moves << i unless cell }
    moves
  end
end
