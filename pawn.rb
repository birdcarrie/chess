class Pawn < Piece

  def initialize(board, pos, color)
    super(board, pos, color)

  end

  def get_possible_moves
    dir = @color == :white ? -1 : 1
    moves = []
    row, col = @pos

    #1 or 2 moves straight ahead
    if @board[[row + dir, col]].nil?
      moves << [row + dir, col]
      if @has_moved == false && @board[[row + dir * 2, col]].nil?
        moves << [row + dir * 2, col]
      end
    end

    #check for potential kills
    new_row = row + dir

    [[new_row, col + 1], [new_row, col - 1]].each do |new_pos|
      next if !@board.in_bounds?(new_pos)
      next if @board[new_pos].nil?
      next if @board[new_pos].color == self.color
      moves << new_pos
    end

    moves

  end

  def to_s
    " \u{265F} "
  end

end
