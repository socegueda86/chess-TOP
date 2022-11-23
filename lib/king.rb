require_relative 'pieces.rb'
require_relative 'check_module.rb'

class King < Pieces
  
  def initialize(color, piece_position)
    @piece_type = :king
    @color = color
    @icon = icon_define
    @piece_position
    @first_move = true
  end

  def first_move_switch
    @first_move = false
  end
  
  def to_s
    @icon 
  end

  def king_moves ;   end



end




