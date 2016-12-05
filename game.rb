require './board'
require './player'

class Game
  def initialize
    @board = Board.new
    @playerX = Player.new('X')
    @playerO = Player.new('O')
    @@turn_counter = 0
  end

  def player_move(player, cell_num)
    @board.change_state(cell_num, player.symbol)
  end

  def turn
    @board.print_board
    puts 'Choose cell'
    cell = gets.to_i
    @@turn_counter % 2 == 0 ? player_move(@playerX, cell) : player_move(@playerO, cell)
    # @board.print_board
    # puts 'Choose cell'
    # cell = gets.to_i
    # player_move(@playerX, cell)
    # @board.print_board
    puts
    @@turn_counter += 1
  end

  def has_ended?
    return false if @@turn_counter < 5
    if [@board.board[0], @board.board[1], @board.board[2]].uniq.count == 1 or
        [@board.board[3], @board.board[4], @board.board[5]].uniq.count == 1 or
        [@board.board[6], @board.board[7], @board.board[8]].uniq.count == 1 or
        [@board.board[0], @board.board[4], @board.board[8]].uniq.count == 1 or
        [@board.board[2], @board.board[4], @board.board[6]].uniq.count == 1
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