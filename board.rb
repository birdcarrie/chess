class Board
  attr_accessor :selected
  def initialize(fill = true)
    @grid = Array.new(8) {Array.new(8)}
    @selected = false
    fill_board if fill
  end

  def in_check?(color)
    other_color = color == :white ? :black : :white
    king_pos = find_king(color)
    pieces(other_color).any? do |piece|
      piece.get_possible_moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)
    pieces(color).all? {|piece| piece.valid_moves.empty? }
  end

  def stalemate?(color)
    return false if in_check?(color)
    pieces(color).all? {|piece| piece.valid_moves.empty? }
  end

  def make_move(from_pos, to_pos)
    make_castle_move(from_pos, to_pos) if castle_move?(from_pos, to_pos)
    self[to_pos] = self[from_pos]
    self[to_pos].pos = to_pos
    self[to_pos].has_moved = true
    self[from_pos] = nil
  end

  def castle_move?(from_pos, to_pos)
    self[from_pos].is_a?(King) && (to_pos[1] - from_pos[1]).abs > 1
  end

  def make_castle_move(from_pos, to_pos)
    if to_pos[1] == 2
      rook_from_pos = [to_pos[0], 0]
      rook_to_pos = [to_pos[0], 3]
    else
      rook_from_pos = [to_pos[0], 7]
      rook_to_pos = [to_pos[0], 5]
    end
    make_move(rook_from_pos, rook_to_pos)

  end

  def find_king(color)
    pieces(color).each do |piece|
      if piece.is_a?(King)
        return piece.pos
      end
    end
  end

  def pieces(color = nil)
    pieces = []
    @grid.flatten.each do |cell|
      pieces << cell unless cell.nil?
    end
    pieces.select {|piece| color.nil? || piece.color == color}
  end

  def dup
    new_board = Board.new(false)
    pieces.each do |piece|
      new_piece = piece.class.new(new_board, piece.pos, piece.color)
      new_board[piece.pos] = new_piece
    end
    new_board
  end

  def fill_board
    [:white, :black].each do |color|
      fill_back_row(color)
      fill_pawns(color)
    end
  end

  def fill_back_row(color)
    row = color == :black ? 0 : 7

    pieces = [  Rook,
                Knight,
                Bishop,
                Queen,
                King,
                Bishop,
                Knight,
                Rook
              ]


    8.times do |col|
      @grid[row][col] = pieces[col].new(self, [row, col], color)
    end
  end

  def fill_pawns(color)
    row = color == :black ? 1 : 6

    8.times do |col|
      @grid[row][col] = Pawn.new(self, [row, col], color)
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def in_bounds?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end

end
