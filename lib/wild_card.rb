require_relative './draw_board_module.rb'  #erase this just for debugging
require_relative './pieces.rb'
require_relative './moves_module.rb'


# this class will be used to check for checks
class WildCard < Pieces
  
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

  # mock its important, if false it'll just 1 square in each direction,
  # if true, it will check
  def check_for_checks(from, to, piece, color, one_square_move = true)
    free= []
    capture = []
    board = mock == true ? pseudo_board_creator : @game.board
    free, capture = available_moves((DIAGONAL+STRAIGHT+KNIGHT_MOVES), board, mock)
  end
end



