require_relative 'pieces.rb'
require_relative 'check_module.rb'
require_relative './draw_board_module.rb'  #erase this just for debugging

class King < Pieces
  
  include DrawBoard #erase this just for debugging
  include MovesModule
  include ChecksModule
  attr_reader :piece_position, :color, :piece_type, :first_move

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




