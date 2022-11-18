
require_relative './draw_board_module.rb'  #erase this just for debugging
require_relative './pieces.rb'
require_relative './moves_module.rb'

class Bishop < Pieces

  include DrawBoard #erase this just for debugging
  include MovesModule

  attr_reader :color
  
  def initialize(color, piece_position)
    @piece_type = :bishop
    @color = color
    @icon = icon_define
    @piece_position = piece_position

  end

  def to_s
    @icon 
  end
end


