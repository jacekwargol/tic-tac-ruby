class Board
  attr_accessor :board

  def initialize(*cells)
    @board = Array.new(9)
    if !cells.empty?
      cells.each_with_index { |cell, i| @board[i] = cell if cell == 'O' or cell == 'X' }
    end
  end

  def print_board
    @board.each_with_index do |ch, i|
      ch = '_' if !ch
      (i-1) % 3 == 0 ? print('|', ch, '|') : print(ch)
      print("\n") if (i+1) % 3 == 0
    end
  end

  def change_cell(cell_num, symbol)
    @board[cell_num] = symbol
    self
  end

  def cells_equal(*cells)
    cells.all? { |cell| cell and (cell == cells[0]) }
  end

  def find_possible_moves
    moves = []
    @board.each_with_index { |cell, i| moves << i unless cell }
    moves
  end
  #
  # def get_no_cell_with_symbol(symbol)
  #
  # end
end


# b = Board.new('X')
# # print b.board[1]
# # print b.board[-1]
# b.print_board
# b.change_cell(1, 'O').print_board
# print b.find_possible_moves
# puts
# b.change_cell(2, 'a')
# 9.times { |i| b.change_cell(i, 'a') }
# print b.find_possible_moves.empty?
# puts
# b.change_board(['o', 'o', nil, nil, nil, nil, nil, nil, nil])
# b.print_board

