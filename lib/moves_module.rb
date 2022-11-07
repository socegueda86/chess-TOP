module MovesModule

  DIRECTIONS_SUMMANDS_HASH = {up_right: [1, 1], down_right: [-1, 1], up_left: [1, -1],
    down_left: [-1, -1], down: [-1, 0], up: [1, 0], left: [0, -1],
    right: [0, -1], knight_up_right: [2, 1], knight_right_up: [1, 2],
    knight_right_down: [-1, 2], knight_down_right: [-2, 1], knight_down_left: [-2, -1],
    knight_left_down: [-1, -2], knight_left_up: [-2, 1], knight_up_left: [-1, -2]}

  DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
  STRAIGHT = [:up, :down, :right, :left]
  KNIGHT_MOVES = [:knight_up_right, :knight_right_up, :knight_right_down,
                  :knight_down_right, :knight_down_left, :knight_left_down,
                  :knight_left_up, :knight_up_left]

  def available_moves(directions)
    free_squares_array = []
    capture_squares_array = []
    

    directions.each do |direction| 
      free_squares, capture_squares = piece_possible_moves(directions) ### add thetype (knight, queen etc)
      free_squares_array << free_squares
      capture_squares_array << capture_squares
    end

    [free_squares_array.flatten(1), capture_squares_array.flatten(1)]
  end

  def piece_possible_moves(directions)
    return possible_moves_queen_tower_bishop_knight(directions) if [:bishop, :tower, :queen, :knight].include?(@piece_type)
  end  

  def possible_moves_queen_tower_bishop_knight(direction)
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
      break if @piece_type == :knight
    end
  
    [free_squares, capture_squares]
  end

  def king_movements
  end

  def next_move_inside_the_board?(row, column, direction)
    return false if row + direction_summands(direction)[0] > 7 || column + direction_summands(direction)[1] > 7
    return false if row + direction_summands(direction)[0] < 0 || column + direction_summands(direction)[1] < 0
    true
  end

  def direction_summands(direction)
    DIRECTIONS_SUMMANDS_HASH.fetch(direction)
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