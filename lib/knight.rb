class Knight < Pieces
  
  def initialize(color, piece_position)
    @piece_type = :knight
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
  
end