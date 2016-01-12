class King < SteppingPiece

  def initialize(board, pos, color)
    super(board, pos, color)
    @possible_directions = [[ 1, 1 ],
                            [-1, 1 ],
                            [-1,-1 ],
                            [ 1,-1 ],
                            [ 1, 0 ],
                            [ 0, 1 ],
                            [-1, 0 ],
                            [ 0,-1 ]]
  end

  def get_possible_moves
    super(@possible_directions)
  end

  def to_s
    " \u{265A} "
  end


end
