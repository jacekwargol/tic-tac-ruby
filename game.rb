class Game
  def self.initialize
    @board = %w(_| _ |_
                _| _ |_
                _| _ |_)
  end

  def self.print_board
    @board.each_with_index do |ch, i|
      [2, 5, 8].include?(i) ? print(ch + "\n") : print(ch)
    end
  end
end


Game.initialize
Game.print_board
