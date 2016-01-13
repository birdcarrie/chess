require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'pieces.rb'
require_relative 'errors.rb'
require_relative 'player.rb'
require_relative 'humanplayer.rb'
require_relative 'computerplayer.rb'
require 'colorize'
require 'byebug'

class Game
  attr_reader :board, :selected, :turn, :players

  def initialize(player1, player2)
    @board = Board.new
    @display = Display.new(@board, self)
    @turn = :white
    @players = {:white => player1, :black => player2}
    @players.each do |color, player|
      player.setup_player(color, @board, @display)
    end
  end

  def play
    @display.render
    until over?

      begin
        user_input = @players[@turn].get_input
        update_game(user_input) unless user_input.nil?
      rescue StandardError => error
        puts error.message
        retry
      end
      @display.render
    end

    if @winner != :tie
      puts "checkmate!"
      puts "the winner is: #{@players[@winner].name} (#{@winner})"
    else
      puts "tie game"
    end

  end

  def update_game(input)

    if @board.selected == false
      select_pos_to_move(input)
    else
      if input == @board.selected
        unselect
      elsif @board[@board.selected].valid_moves.include?(input)
        @board.make_move(@board.selected, input)
        @board.selected = false
        switch_player
      else
        raise_invalid_move_error(input)
      end
    end
  end

  def raise_invalid_move_error(pos)
    if @board[@board.selected].get_possible_moves.include?(pos)
      raise PutSelfInCheckError.new(
      "You can't move there, \nit will leave you in check"
      )
    else
      raise InvalidMoveError.new(
      "You can't move there, \nthat piece doesn't move like that!"
      )
    end
  end

  def select_pos_to_move(pos)
    if !@board[pos].nil? && @board[pos].color == @turn
      @board.selected = pos
    else
      raise InvalidSelectionError.new "Select your own piece!"
    end
  end

  def unselect
    @board.selected = false
  end

  def switch_player
    @turn = @turn == :white ? :black : :white
  end

  def over?
    if @board.checkmate?(@turn)
      @winner = @turn == :white ? :black : :white
      return true
    elsif @board.stalemate?(@turn)
      @winner = :tie
      return true
    else
      return false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new("Player 1")
  p2 = ComputerPlayer.new("Player 2")
  p3 = HumanPlayer.new("Player 3")
  Game.new(p1, p2).play
end
