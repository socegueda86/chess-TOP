class Knight < Pieces

  attr_reader :piece_position, :color, :piece_type
  def initialize(color, piece_position)
    @piece_type = :knight
    @color = color
    @icon = icon_define
    @piece_position = piece_position
  end

  def to_s
    @icon 
  end
  
end