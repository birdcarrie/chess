class Knight < SteppingPiece
  attr_reader :possible_directions
  def initialize(board, pos, color)
    super(board, pos, color)
    @possible_directions = [[ 2, 1 ],
                            [-2, 1 ],
                            [ 2,-1 ],
                            [ -2,-1 ],
                            [ 1, 2 ],
                            [ 1, -2 ],
                            [-1, 2 ],
                            [ -1,-2 ]]
  end

  def get_possible_moves
    super(@possible_directions)
  end

  def to_s
    " \u{265E} "
  end

end
