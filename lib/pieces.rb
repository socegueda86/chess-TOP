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

  def piece_position(board, piece = self)
    position = []

    board.each_with_index do |row, index_1|
      row.each_with_index do |square, index_2|
         return [[index_1, index_2], piece.color, piece.piece_type] if board[index_1][index_2] == piece
      end
    end
    position
  end
end