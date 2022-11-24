require_relative './pieces.rb'
require_relative './moves_module.rb'

class Pawn < Pieces

  include MovesModule
  attr_reader :piece_position, :color, :piece_type
  
  def initialize(color, piece_position)
    @piece_type = :pawn
    @color = color
    @icon = icon_define
    @piece_position = piece_position

  end

  def to_s
    @icon 
  end
end