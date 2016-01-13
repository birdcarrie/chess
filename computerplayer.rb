class ComputerPlayer < Player

  def initialize(name)
    super(name)
    @move_waiting = nil
  end

  def get_input
    if @move_waiting.nil?
      move = get_move
      @move_waiting = move[1]
      move[0]
    else
      next_move = @move_waiting
      @move_waiting = nil
      @display.cursor_pos = next_move
      next_move
    end
  end

  def get_move
    @board.pieces(@color).each do |piece|
      piece.valid_moves.each do |move|
        new_board = @board.dup
        new_board.make_move(piece.pos, move)
        return [piece.pos, move] if new_board.in_check?(@other_color)
      end
    end

    @board.pieces(@color).shuffle.each do |piece|
      unless piece.valid_moves.empty?
        sleep(2)
        return [piece.pos, piece.valid_moves.sample]
      end
    end
  end


end
