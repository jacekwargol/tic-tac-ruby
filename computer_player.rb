require './game'
require './board'


class ComputerPlayer
  def initialize(game)
    @game = game
    @symbol = 'O'
  end

  def get_score(game)
    unless game.winner
      return 0
    end
    if game.winner.symbol == 'O'
      return 1
    elsif game.winner.symbol == 'X'
      return -1
    end
  end

  def find_best_move(game)
    if game.has_ended?
      return get_score(game)
    end
    scores = []
    moves = []

    game.board.find_possible_moves.each do |move|
      game_copy = Game.new(game.board.board)
      game_copy.player_move(move)
      scores << find_best_move(game_copy)
      moves << move
    end

    if game.active_player.symbol == 'O'
      max_score_index = scores.each_with_index.max[1]
      @choice = moves[max_score_index]
      return scores.max
    else
      min_score_index = scores.each_with_index.min[1]
      @choice = moves[min_score_index]
      return scores.min
    end
  end

  def make_move
    find_best_move(@game)
    puts @choice
    @game.player_move(@choice)
    @choice
  end
end


#
# b = Board.new(3)
game = Game.new
cp = ComputerPlayer.new(game)
cp.make_move
cp.make_move
cp.make_move
cp.make_move
