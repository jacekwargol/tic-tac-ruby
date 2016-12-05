class Board
  def initialize
    @board = %w(_| _ |_
                _| _ |_
                _| _ |_)
  end

  def print_board
    @board.each_with_index do |ch, i|
      [2, 5, 8].include?(i) ? print(ch + "\n") : print(ch)
    end
  end

  def change_state(cell_num, symbol)
    @board[cell_num] = symbol
  end
end