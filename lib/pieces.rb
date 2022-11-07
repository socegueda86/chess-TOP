require_relative './draw_board_module.rb' #erase-line this just for debugging
require_relative './moves_module.rb'
class Piece

  include DrawBoard #erase-line this just for debugging
  include MovesModule
  attr_reader :color

  DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
  STRAIGHT = [:up, :down, :right, :left]
  KNIGHT_MOVES = [:knight_up_right, :knight_right_up, :knight_right_down,
                  :knight_down_right, :knight_down_left, :knight_left_down,
                  :knight_left_up, :knight_up_left]

  
  def initialize(game, piece, color, piece_position)
    @game = game
    @piece = piece
    @color = color
    @icon ||= icon_define
    @piece_position = piece_position
  end

  def to_s
    @icon 
  end

   def icon_define
        
    case @piece
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