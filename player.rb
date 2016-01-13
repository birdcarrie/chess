class Player
  attr_accessor :color, :board, :display
  attr_reader :name
  def initialize(name)
    @name = name
    @color = nil
    @board = nil
    @display = nil
  end

  def setup_player(color, board, display)
    self.board = board
    self.display = display
    self.color = color
    @other_color = @color == :white ? :black : :white
  end
end
