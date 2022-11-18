require_relative 'pieces.rb'

class Tower < Pieces
  
  def initialize(color, piece_position, first_move = true)
    @piece_type = :tower
    @color = color
    @icon = icon_define
    @piece_position
    @first_move = first_move 
  end

  def to_s
    @icon 
  end
end