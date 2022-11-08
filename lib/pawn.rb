class Pawn < Pieces
  
  def initialize(game, color, piece_position, first_move = true)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
    @first_move = first_move 
  end
  
  def to_s
    @icon 
  end
end
