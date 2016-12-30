require './board'
require './player'
require './computer_player'

class Game
  attr_accessor :board, :player_o, :player_x, :player_ai, :winner, :active_player

  def initialize(*cells)
    @player_x = Player.new('X')
    @player_o = Player.new('O')
    @active_player = @player_x
    @board = Board.new
    if !cells.empty?
      cells[0].each_with_index { |cell, i| @board.change_cell(i, cell) if cell}
      @active_player = (@board.board.count('X') > @board.board.count('O') ? @player_o : @player_x)
    end
  end

  def start_game
    puts 'Hello.'
    puts 'Choose game mode:'
    puts '1. Two-player game.'
    puts '2. Game against ai.'
    until (@user_choice = gets.chomp.to_i).between?(1, 2)
      puts "I don't understand."
    end

    @player_o = ComputerPlayer.new(self) if @user_choice == 2
    game_loop
  end

  def game_loop
    until has_ended?
      turn
      player_o.make_move if(@user_choice == 2)
    end

    end_game
  end

  def player_move(cell_num)
    @board.change_cell(cell_num, @active_player.symbol)
    change_active_player
  end

  def change_active_player
    @active_player = (@active_player == player_x ? player_o : player_x)
    @active_player
  end

  def turn
    @board.print_board
    puts "Player #{@active_player.symbol}, choose cell:"
    until (cell = gets.to_i).between?(0, 8) and !@board.board[cell]
      puts 'Please choose number between 0 and 8. Cell must be empty:'
    end
    player_move(cell)
    puts
  end

  def has_ended?
    if horizontal_win? or vertical_win? or diagonal_win?
      @winner = change_active_player
      return true
    elsif @board.find_possible_moves.empty?
      @winner = nil
      return true
    end

    return false
  end

  def horizontal_win?
    @board.cells_equal?(@board.board[0], @board.board[1], @board.board[2]) or
        @board.cells_equal?(@board.board[3], @board.board[4], @board.board[5]) or
        @board.cells_equal?(@board.board[6], @board.board[7], @board.board[8])
  end

  def vertical_win?
    @board.cells_equal?(@board.board[0], @board.board[3], @board.board[6]) or
        @board.cells_equal?(@board.board[1], @board.board[4], @board.board[7]) or
        @board.cells_equal?(@board.board[2], @board.board[5], @board.board[8])
  end

  def diagonal_win?
    @board.cells_equal?(@board.board[0], @board.board[4], @board.board[8]) or
        @board.cells_equal?(@board.board[2], @board.board[4], @board.board[6])
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
end