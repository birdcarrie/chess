class Pawn < Piece

  def initialize(board, pos, color)
    super(board, pos, color)

  end

  def get_possible_moves
    step_direction = @color == :white ? -1 : 1
    possible_moves = []
    row, col = @pos

    possible_moves << [row + step_direction, col] if @board[[row + step_direction, col]].nil?
    possible_moves << [row + step_direction * 2, col] if possible_moves.length == 1 && @has_moved == false && @board[[row + step_direction * 2, col]].nil?

    new_row = row + step_direction

    [[new_row, col + 1], [new_row, col - 1]].each do |new_pos|
      possible_moves << new_pos if !@board[new_pos].nil? && @board[new_pos].color != self.color
    end

    possible_moves

  end

  def to_s
    " \u{265F} "
  end

end
