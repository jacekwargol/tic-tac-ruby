require './board'
require './player'

class Game
  def initialize
    @board = Board.new
    @playerX = Player.new('X')
    @playerO = Player.new('O')
  end

  def player_move(player, cell_num)
    @board.change_state(cell_num, player.symbol)
  end

  def turn
    @board.print_board
    puts 'Choose cell'
    cell = gets.to_i
    player_move(@playerO, cell)
    @board.print_board
  end
end


game = Game.new
game.turn