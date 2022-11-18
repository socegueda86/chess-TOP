class Queen < Pieces
  
  def initialize(color, piece_position)
    @piece_type = :queen
    @color = color
    @icon = icon_define
    @piece_position
  end

  def to_s
    @icon 
  end
end
