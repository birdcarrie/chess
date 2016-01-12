class HumanPlayer < Player

  def initialize(name)
    super(name)
  end

  def get_input
    @display.get_input
  end

end
