
require_relative './draw_board_module.rb'  #erase this just for debugging
require_relative './pieces.rb'
require_relative './moves_module.rb'

class Bishop < Pieces

  include DrawBoard #erase this just for debugging
  include MovesModule

  attr_reader :color
  
  def initialize(game, color, piece_position)
    @game = game
    @color = color
    @icon = icon_define
    @piece_position = piece_position
  end

  def to_s
    @icon 
  end

  def available_moves
    free_squares_array = []
    capture_squares_array = []
    directions = [:up_right, :down_right, :up_left, :down_left]

    directions.each do |direction| 
      f_squares, c_squares = posible_moves_q_t_b(direction)
      free_squares_array << f_squares
      capture_squares_array << c_squares
    end

    [free_squares_array.flatten(1), capture_squares_array.flatten(1)]
  end

   
end

