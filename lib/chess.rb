class Game
  def initialize(player_1_class, player_2_class)
    @board = create_board()
    @players = [player_1_class.new, player_2_class.new]
  end

  def create_board
    (1..8).map  { |x| Array.new(8) }
  end

  
end
