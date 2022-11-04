class Game
  def initialize(player_1_class, player_2_class)
    @board = create_board()
    @players = [player_1_class.new, player_2_class.new]
  end

  def create_board
    (1..8).map  { |x| Array.new(8) }
  end

  # will create test when i have added the pieces icons
  def draw_board 
    if player_1_class.class == ComputerPlayer && player_1_class.class == HumanPlayer
      draw_board_blacks_perspective
    else
      draw_board_whites_perspective
    end
  end
end


class Player;end

class HumanPlayer;end
class ComputerPlayer;end
