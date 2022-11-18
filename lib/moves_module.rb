

module MovesModule

  DIRECTIONS_SUMMANDS_HASH = {up_right: [1, 1], down_right: [-1, 1], up_left: [1, -1],
    down_left: [-1, -1], down: [-1, 0], up: [1, 0], left: [0, -1],
    right: [0, 1], knight_up_right: [2, 1], knight_right_up: [1, 2],
    knight_right_down: [-1, 2], knight_down_right: [-2, 1], knight_down_left: [-2, -1],
    knight_left_down: [-1, -2], knight_left_up: [-2, 1], knight_up_left: [-1, -2]}

  DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
  STRAIGHT = [:up, :down, :right, :left]
  KNIGHT_MOVES = [:knight_up_right, :knight_right_up, :knight_right_down,
                  :knight_down_right, :knight_down_left, :knight_left_down,
                  :knight_left_up, :knight_up_left]
  

  def available_moves(directions, board, mock = true )
    free_squares_array = []
    capture_squares_array = []
    
    directions.each do |direction| 
      free_squares, capture_squares = piece_possible_moves(direction, board) ### add thetype (knight, queen etc)
      free_squares_array << free_squares
      capture_squares_array << capture_squares
    end

    [free_squares_array.flatten(1), capture_squares_array.flatten(1)]
  end

  def piece_possible_moves(direction, board, pawn = false) #pending create a method to analyze pawns
    return possible_moves_queen_tower_bishop_knight_king(direction, board) if [:bishop, :tower, :queen, :knight, :king].include?(self.piece_type)
  end  

  def possible_moves_queen_tower_bishop_knight_king(direction, board, row = @piece_position[0], column = @piece_position[1])
    free_squares = []
    capture_squares = []
  
    while next_move_inside_the_board?(row, column, direction)
      row += direction_summands(direction)[0] 
      column += direction_summands(direction)[1]

      break if same_color_piece?(row, column, board)
      break capture_squares << [row, column, board[row][column]] if opponent_color_piece?(row, column, board) 

      free_squares << [row, column] if board[row][column].nil?
      break if self.piece_type == :knight || self.class == :king
    end
  
    [free_squares, capture_squares]
  end

  def directions_piece_can_move(piece_type = self.piece_type)
    return DIAGONAL + STRAIGHT if piece_type == :queen || piece_type == :king
    return DIAGONAL if piece_type == :bishop
    return STRAIGHT if piece_type == :tower
    return KNIGHT_MOVES if piece_type == :knight
  end


  def next_move_inside_the_board?(row, column, direction)
    return false if row + direction_summands(direction)[0] > 7 || column + direction_summands(direction)[1] > 7
    return false if row + direction_summands(direction)[0] < 0 || column + direction_summands(direction)[1] < 0
    true
  end

  def direction_summands(direction)
    DIRECTIONS_SUMMANDS_HASH.fetch(direction)
  end
  
  def same_color_piece?(row, column, board)  
    return false if board[row][column].nil?
    return true if board[row][column].color == @color
    false    
  end

  def opponent_color_piece?(row, column, board, self_color = self.color )
    oppossite_color = self_color == :white ? :black : :white
    return false if board[row][column].nil?
    return true if board[row][column].color == oppossite_color
    false    
  end

  def pawn_normal_capture(row, column, board)
    capture_array = []
    capture_array << [row + 1, column + 1] unless  check_for_checks(row + 1, column + 1) || board[row + 1][column + 1].nil? || board[row + 1][column + 1].color == @color 
    capture_array << [row + 1, column - 1] unless  check_for_checks(row + 1, column - 1) || board[row + 1][column - 1].nil? || board[row + 1][column - 1].color == @color
    #capture_array << unless check_for_checks    
  end
end

