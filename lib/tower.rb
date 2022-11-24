require_relative 'pieces.rb'

class Tower < Pieces
  
  include MovesModule
  attr_reader :piece_position, :color, :piece_type, :first_move
  def initialize(color, piece_position)
    @piece_type = :tower
    @color = color
    @icon = icon_define
    @piece_position = piece_position
    @first_move = true
  end

  def first_move_switch
    @first_move = false
  end

  def to_s
    @icon 
  end
end