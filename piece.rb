

class Piece

  attr_reader :color
  attr_accessor :pos, :has_moved

  def initialize(board, pos, color)
    @board = board
    @pos = pos     # [row, col]
    @color = color # :white or :black
    @has_moved = false
  end

  def valid_moves
    self.get_possible_moves.select do |move|
      new_board = @board.dup
      new_board.make_move(self.pos, move)
      !new_board.in_check?(self.color)
    end
  end

end

class SlidingPiece < Piece
  def initialize(board, pos, color)
    super(board, pos, color)

  end

  def get_possible_moves(possible_directions)
    row, col = @pos
    moves =[]
    possible_directions.each do |direction|
      d_row, d_col = direction
      scale = 1
      test_position = [row + d_row, col + d_col]
      until !@board.in_bounds?(test_position)
        break if !@board[test_position].nil? && @board[test_position].color == self.color
        moves << test_position
        break if !@board[test_position].nil? && @board[test_position].color != self.color
        scale += 1
        test_position = [row + d_row * scale, col + d_col * scale]
      end

    end
    moves
  end
end

class SteppingPiece < Piece
  def initialize(board, pos, color)
    super(board, pos, color)
  end

  def get_possible_moves(possible_directions)
    row, col = @pos
    moves = []
    possible_directions.each do |direction|
      d_row, d_col = direction
      new_pos = [row + d_row, col + d_col]
      next if !@board.in_bounds?(new_pos)
      next if !@board[new_pos].nil? && @board[new_pos].color == self.color
      moves << new_pos if @board.in_bounds?(new_pos)
    end
    moves
  end

end
