require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'pieces.rb'
require_relative 'errors.rb'
require 'colorize'
require 'byebug'

class Game
  attr_reader :board, :selected, :turn
  def initialize
    @board = Board.new
    @display = Display.new(@board, self)
    @turn = :white

  end

  def play
    @display.render
    until over?
      begin
        user_input = @display.get_input
        update_game(user_input) unless user_input.nil?
      rescue StandardError => error
        puts error.message
        retry
      end
      @display.render
    end

    if @winner != :tie
      puts "checkmate!"
      puts "the winner is: #{@winner}"
    else
      puts "tie game"
    end

  end

  def update_game(input)

    if @board.selected == false
      unless !@board[input].nil? && @board[input].color == @turn
        raise InvalidSelectionError.new "Select your own piece!"
      else
        @board.selected = input
      end
    else
      if input == @board.selected
        @board.selected = false
        return
      end
      unless @board[@board.selected].valid_moves.include?(input)
        raise InvalidMoveError.new "You can't move there!"
      else
        @board.make_move(@board.selected, input)
        @board.selected = false
        switch_player
      end
    end
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
  Game.new.play
end
