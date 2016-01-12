class Player
  attr_accessor :color, :board, :display
  attr_reader :name
  def initialize(name)
    @name = name
    @color = nil
    @board = nil
    @display = nil

  end

  def set_color(color)
    @color = color
    @other_color = @color == :white ? :black : :white
  end
end
