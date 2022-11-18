require_relative './draw_board_module.rb' #erase-line this just for debugging
require_relative './moves_module.rb'

class Pieces

   def icon_define
        
    case @piece_type
    when :pawn
      @color == :white ? '♟︎' : '♙'
    when :king
      @color == :white ? '♚' : '♔'
    when :queen
      @color == :white ? '♛' : '♕'
    when :bishop
      @color == :white ? '♝' : '♗'
    when :tower
      @color == :white ? '♜' : '♖'
    when :knight
      @color == :white ? '♞' : '♘'
    else
      'E'
    end
  end
  
end