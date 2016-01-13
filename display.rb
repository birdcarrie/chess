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
    selected_pos = @board.selected
    selected_piece = selected_pos ? @board[selected_pos] : nil
    possible_moves = selected_pos ? selected_piece.valid_moves : nil

    (0..7).each do |i|
      (0..7).each do |j|
        print_cell(i, j, selected_pos, selected_piece, possible_moves)
      end
      puts
    end

    if @board.in_check?(@game.turn)
      puts "Check!" unless @board.checkmate?(@game.turn)
    end
  end

  def print_cell(i, j, selected_pos, selected_piece, possible_moves)
    piece = @board[[i,j]]
    if !piece.nil?
      cell = piece.to_s.colorize(piece.color)
    else
      cell = "   "
    end

    if [i, j] == selected_pos
      print cell.colorize( :background => :red)
    elsif @cursor_pos == [i, j]
      print cell.colorize( :background => :green)
    elsif selected_pos && possible_moves.include?([i, j])
      print cell.colorize( :background => :yellow)
    elsif (i+j).even?
      print cell.colorize( :background => :blue)
    else
      print cell.colorize( :background => :light_blue)
    end
  end
end
