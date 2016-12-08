require './board'
require './player'
require './computer_player'

class Game
  attr_accessor :board, :player_o, :player_x, :winner

  def initialize(*cells)
    @board = Board.new
    if !cells.empty?
      cells[0].each_with_index { |cell, i| @board.change_cell(i, cell) if cell}
    end
    @player_x = Player.new('X')
    @player_o = ComputerPlayer.new(self)
    @active_player = @player_x
  end

  def player_move(cell_num)
    @board.change_cell(cell_num, active_player.symbol)
  end

  def active_player
    @board.board.count('X') > @board.board.count('O') ? @player_o : @player_x
  end

  def turn
    @board.print_board
    puts 'Choose cell:'
    until (cell = gets.to_i).between?(0, @board.board.size-1) and !@board.board[cell]
      puts 'Please choose number between 0 and 8. Cell must be empty:'
    end
    player_move(cell)
    change_active_player
    puts
  end

  def has_ended?
    if @board.cells_equal?(@board.board[0], @board.board[1], @board.board[2], 'X') or
        @board.cells_equal?(@board.board[3], @board.board[4], @board.board[5], 'X') or
        @board.cells_equal?(@board.board[6], @board.board[7], @board.board[8], 'X') or
        @board.cells_equal?(@board.board[0], @board.board[3], @board.board[6], 'X') or
        @board.cells_equal?(@board.board[2], @board.board[5], @board.board[8], 'X') or
        @board.cells_equal?(@board.board[0], @board.board[4], @board.board[8], 'X') or
        @board.cells_equal?(@board.board[2], @board.board[4], @board.board[6], 'X')
      @winner = @active_player
      return true
    elsif @board.cells_equal?(@board.board[0], @board.board[1], @board.board[2], 'O') or
        @board.cells_equal?(@board.board[3], @board.board[4], @board.board[5], 'O') or
        @board.cells_equal?(@board.board[6], @board.board[7], @board.board[8], 'O') or
        @board.cells_equal?(@board.board[0], @board.board[3], @board.board[6], 'O') or
        @board.cells_equal?(@board.board[2], @board.board[5], @board.board[8], 'O') or
        @board.cells_equal?(@board.board[0], @board.board[4], @board.board[8], 'O') or
        @board.cells_equal?(@board.board[2], @board.board[4], @board.board[6], 'O')
      @winner = player_o
      return true
    elsif @board.find_possible_moves.empty?
      @winner = nil
      return true
    end

    return false
  end

  def has_won?(player)
    @active_player != player
  end

  def end_game
    puts '----------'
    @board.print_board
    if @winner
      puts "Congratulations, player #{@winner.symbol}, you have won."
    else
      puts 'A draw.'
    end
  end

  def game_loop
    until has_ended?
      turn
      player_o.make_move
    end

    end_game
  end
end

#

