require_relative './draw_board_module.rb' #erase-line this just for debugging
require_relative './moves_module.rb'

class Pieces

  include DrawBoard #erase-line this just for debugging
  include MovesModule
  attr_reader :color, :first_move

  

  
  def initialize(game, piece_type, color, piece_position)
    @game = game
    @piece_type = piece_type
    @color = color
    @icon ||= icon_define
    @piece_position = piece_position
    @first_move = first_move
  end

  def to_s
    @icon 
  end

   def icon_define
        
    case self
    when Pawn
      @color == :white ? '♟︎' : '♙'
    when King
      @color == :white ? '♚' : '♔'
    when Queen
      @color == :white ? '♛' : '♕'
    when Bishop
      @color == :white ? '♝' : '♗'
    when Tower
      @color == :white ? '♜' : '♖'
    when Knight
      @color == :white ? '♞' : '♘'
    else
      'E'
    end
  end
  
end