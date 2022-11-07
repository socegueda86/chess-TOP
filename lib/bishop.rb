
require_relative 'draw_board_module.rb'  #erase this just for debugging
require_relative './pieces.rb'

class Bishop < Pieces

  include DrawBoard #erase this just for debugging
  
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
      f_squares, c_squares = posible_diagonal_moves(direction)
      free_squares_array << f_squares
      capture_squares_array << c_squares
    end

    [free_squares_array.flatten(1), capture_squares_array.flatten(1)]
  end

  def posible_diagonal_moves(direction)
    @game.board
    row = @piece_position[0]
    column = @piece_position[1]
    free_squares = []
    capture_squares = []
  
    while next_move_inside_the_board?(row, column, direction)
      row += direction_summands(direction)[0]
      column += direction_summands(direction)[1]
      
      break if same_color_piece?(row, column)
      break capture_squares << [row, col, @game.board[row][col]] if opponent_color_piece?(row, column)
      free_squares << [row, column] if @game.board[row][column].nil?
    end
  
    [free_squares, capture_squares]
  end

  def next_move_inside_the_board?(row, column, direction)
    return false if row + direction_summands(direction)[0] > 7 || column + direction_summands(direction)[1] > 7
    return false if row + direction_summands(direction)[0] < 0 || column + direction_summands(direction)[1] < 0
    true
  end
  
  def direction_summands(direction)
  
    return [1, 1] if direction == :up_right
    return [-1, 1] if direction == :down_right
    return [1, -1] if direction == :up_left
    return [-1, -1] if direction == :down_left
    
    raise StandardError "Error on Bishop#direction_summands: the paramater has not been chatched by any if function"
  end

  def same_color_piece?(row, column)  #modifique el board a @game.board, estoy creando same  color piece
    return false if @game.board[row][column].nil?
    return true if @game.board[row][column].color == @color
    false    
  end

  def opponent_color_piece?(row, column)
    return false if @game.board[row][column].nil? 
    return true if @game.board[row][column].color != @color
      false    
  end
 
end

