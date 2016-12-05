require './board'
require './player'

class Game
  def initialize
    @board = Board.new(9)
    @playerX = Player.new('X')
    @playerO = Player.new('O')
    @@turn_counter = 0
  end

  def player_move(player, cell_num)
    @board.change_state(cell_num, player.symbol)
  end

  def turn
    @board.print_board
    puts 'Choose cell:'
    until (cell = gets.to_i).between?(0, @board.board.size-1) and !@board.board[cell]
      puts 'Please choose number between 0 and 8. Cell must be empty:'
    end
    @@turn_counter % 2 == 0 ? player_move(@playerX, cell) : player_move(@playerO, cell)
    puts
    @@turn_counter += 1
  end

  def has_ended?
    return false if @@turn_counter < 5
    if @board.cells_equal(@board.board[0], @board.board[1], @board.board[2]) or
        @board.cells_equal(@board.board[3], @board.board[4], @board.board[5]) or
        @board.cells_equal(@board.board[6], @board.board[7], @board.board[8]) or
        @board.cells_equal(@board.board[0], @board.board[3], @board.board[6]) or
        @board.cells_equal(@board.board[2], @board.board[5], @board.board[8]) or
        @board.cells_equal(@board.board[0], @board.board[4], @board.board[8]) or
        @board.cells_equal(@board.board[2], @board.board[4], @board.board[6])
      return true
    end
  end

  def end_game
    puts '----------'
    @board.print_board
    winner = @@turn_counter % 2 == 1 ? @playerX : @playerO
    puts "Congratulations, player #{winner.symbol}, you have won."
  end

  def game_loop
    until has_ended?
      turn
    end

    end_game
  end
end


game = Game.new
game.game_loop