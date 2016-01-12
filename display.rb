require_relative 'cursorable.rb'

class Display
  include Cursorable

  attr_accessor :cursor_pos

  def initialize(board, game)
    @board = board
    @cursor_pos = [0,0]
    @game = game
  end

  def render
    system('clear')

    puts "#{@game.players[@game.turn].name} (#{@game.turn})"
    puts "it's your turn."

    valid_moves_of_selected_piece = @board[@board.selected].valid_moves if @board.selected

    (0..7).each do |i|
      (0..7).each do |j|
        piece = @board[[i,j]]
        if !piece.nil?
          cell = piece.to_s.colorize(piece.color)
        else
          cell = "   "
        end

        if [i, j] == @board.selected
          print cell.colorize( :background => :red)
        elsif @cursor_pos == [i, j]
          print cell.colorize( :background => :green)
        elsif @board.selected && valid_moves_of_selected_piece.include?([i, j])
          print cell.colorize( :background => :yellow)
        elsif (i+j).even?
          print cell.colorize( :background => :blue)
        else
          print cell.colorize( :background => :light_blue)
        end

      end
      puts
    end
    puts "Check!" if @board.in_check?(@game.turn) && !@board.checkmate?(@game.turn)
  end
end
