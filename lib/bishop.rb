class Bishop < Pieces
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end

  def movement
    
  end
end