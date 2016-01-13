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

   castle_eligible + super(@possible_directions)
  end

  def castle_eligible
    return [] if @has_moved
    castles = []
    row = @pos[0]

    if !@board[[row, 0]].nil? && !@board[[row, 0]].has_moved
      if [1,2,3].all? { |col| @board[[row, col]].nil?}
          castles << [row, 2]
      end
    end

    if !@board[[row, 7]].nil? && !@board[[row, 7]].has_moved
      if [5, 6].all? { |col| @board[[row, col]].nil?}
         castles << [row, 6]
      end
    end

    castles
  end

  $def

  def to_s
    " \u{265A} "
  end


end
