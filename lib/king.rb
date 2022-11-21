require_relative 'pieces.rb'
require_relative 'check_module.rb'

class King < Pieces
  
  def initialize(color, piece_position)
    @piece_type = :king
    @color = color
    @icon = icon_define
    @piece_position
    @castling_right = true
    @castling_left = true
    puts "Remeber too turn them false if the king move or if the tower move for the first time "
    
  end
  
  def to_s
    @icon 
  end

  def king_moves ;   end



end




