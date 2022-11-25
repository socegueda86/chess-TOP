module MovesModule

  DIRECTIONS_SUMMANDS_HASH = {up_right: [1, 1], down_right: [-1, 1], up_left: [1, -1],
    down_left: [-1, -1], down: [-1, 0], up: [1, 0], left: [0, -1],
    right: [0, 1], knight_up_right: [2, 1], knight_right_up: [1, 2],
    knight_right_down: [-1, 2], knight_down_right: [-2, 1], knight_down_left: [-2, -1],
    knight_left_down: [-1, -2], knight_left_up: [1, -2], knight_up_left: [2, -1]}

  DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
  STRAIGHT = [:up, :down, :right, :left]
  KNIGHT_MOVES = [:knight_up_right, :knight_right_up, :knight_right_down,
                  :knight_down_right, :knight_down_left, :knight_left_down,
                  :knight_left_up, :knight_up_left]

  def available_moves(board, piece = self, last_move = nil)
    capture_array = []
    moves_array = []
    if [:bishop, :tower, :queen, :knight, :king].include?(piece.piece_type)
      moves, captures = available_moves_q_t_b_kn_k(board, directions_piece_can_move(piece.piece_type), piece)
      moves_array << moves
      capture_array << captures
    end

    if piece.piece_type == :pawn
      
      raise StandardError "Last move cannot be nil for :pawn piece_type" if last_move.nil?
      capture_array << pawn_normal_capture(board, piece)
      capture_array << en_passant_capture(board, last_move, piece) unless last_move == []
      moves_array << pawn_forward_move(board, piece)
    end

    if piece.piece_type == :king
      moves_array << castling(piece, board)
    end
    [moves_array.flatten(1), capture_array.flatten(1)]
    
  end

  def available_moves_q_t_b_kn_k(board, directions = directions_piece_can_move,  piece = self)
    free_squares_array = []
    capture_squares_array = []

    directions.each do |direction| 
      free_squares, capture_squares = moves_by_direction_q_t_b_kn_k(direction, board, piece) 
      free_squares_array << free_squares
      capture_squares_array << capture_squares
    end

    [free_squares_array.flatten(1), capture_squares_array.flatten(1)]
  end

  #**
  def moves_by_direction_q_t_b_kn_k(direction, board, piece, piece_position = piece.piece_position)

    row = piece_position[0]
    column = piece_position[1]
    free_squares = []
    capture_squares = []

    while next_move_inside_the_board?(row, column, direction)
      row += direction_summands(direction)[0] 
      column += direction_summands(direction)[1]

      break if same_color_piece?(row, column, board)
      break capture_squares << [row, column, board[row][column]] if opponent_color_piece?(row, column, board, piece.color) 

      free_squares << [row, column] if board[row][column].nil?
      break if piece.piece_type == :knight || piece.piece_type == :king
    end
  
    [free_squares, capture_squares]
  end

  def directions_piece_can_move(piece_type = self.piece_type)
    return DIAGONAL + STRAIGHT if piece_type == :queen || piece_type == :king
    return DIAGONAL if piece_type == :bishop
    return STRAIGHT if piece_type == :tower
    return KNIGHT_MOVES if piece_type == :knight
  end ## need to implement  DELafterDEBUG


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

  #************************      
  def opponent_color_piece?(row, column, board, self_color = self.color )
    oppossite_color = self_color == :white ? :black : :white
    return false if board[row][column].nil?
    return true if board[row][column].color == oppossite_color
    false    
  end

#**
  def pawn_normal_capture(board, piece = self, piece_position = piece.piece_position)
    capture_array = []

    row = piece_position[0]
    column = piece_position[1]

    return [] if row == 8 || row == 0
    if piece.color == :white
      capture_array << [row + 1, column + 1, board[row + 1][column + 1]] unless board[row + 1][column + 1].nil? || board[row + 1][column + 1].color == piece.color #  check_for_checks(row + 1, column + 1) ||
      capture_array << [row + 1, column - 1, board[row + 1][column - 1]] unless board[row + 1][column - 1].nil? || board[row + 1][column - 1].color == piece.color #  check_for_checks(row + 1, column - 1) ||
    end

    if piece.color == :black
      capture_array << [row - 1, column + 1, board[row - 1][column + 1]] unless  board[row - 1][column + 1].nil? || board[row - 1][column + 1].color == piece.color # check_for_checks(row + 1, column + 1) ||
      capture_array << [row - 1, column - 1, board[row - 1][column - 1]] unless  board[row - 1][column - 1].nil? || board[row - 1][column - 1].color == piece.color # check_for_checks(row + 1, column - 1) ||
    end
    
    capture_array
  end

  #Pending to test  #**
  def en_passant_capture(board, last_move, piece = self, piece_position = piece.piece_position)

    color = piece.color
    pawn_to_eat_row = last_move[0][0]
    pawn_to_eat_column = last_move[0][1]
    
    if color == :black
      return unless piece_position[0] == 3 # checks if self pawn is inte correc row to use en passant
      return unless last_move[2] == :pawn && last_move[1] == :white # checks if both pieces are pawns and if they have opposite colors
      return unless last_move[0][0] == piece_position[0] # checks if pawns are on the same row and if it was the last move
      return unless last_move[0][1] == piece_position[1] + 1 || last_move[0][1] == piece_position[1] - 1 #checks if opponents pawn is on the correct column and if it was the last move
      return [2 , pawn_to_eat_column, board[pawn_to_eat_row][pawn_to_eat_column]]
    end

    if color == :white
      return unless piece_position[0] == 4 # checks if self pawn is inte correc row to use en passant
      return unless last_move[2] == :pawn && last_move[1] == :black # checks if both pieces are pawns and if they have opposite colors
      return unless last_move[0][0] == piece_position[0] # checks if pawns are on the same row and if it was the last move
      return unless last_move[0][1] == piece_position[1] + 1 || last_move[0][1] == piece_position[1] - 1 #checks if opponents pawn is on the correct column and if it was the last move
      return [5, pawn_to_eat_column, board[pawn_to_eat_row][pawn_to_eat_column]]
    end
    raise StandardError "en_passant_capture error"
  end

  def pawn_forward_move(board, piece, piece_position = piece.piece_position)
    
    moves_array = []
    row = piece_position[0]
    column = piece_position[1]
    color = piece.color

    if color == :white
      moves_array << [row + 1, column] if board[row + 1][column].nil? 
      moves_array << [row + 2, column] if board[row + 1][column].nil? && board[row + 2][column].nil? && row == 1
    end

    if color == :black
      moves_array << [row - 1, column] if board[row - 1][column].nil? &&  board[row - 1][column].nil? 
      moves_array << [row - 2, column] if board[row - 1][column].nil? && board[row - 2][column].nil? && row == 6
    end
    moves_array
  end

    # I have to add a some "if class = King to certaing methods so it works"  #**
  def castling_right?(piece, board = game.board, piece_position = piece.piece_position)

    color = piece.color
    row = piece_position[0]
    column = piece_position[1]

    return false unless check_for_checks(color, board, false).flatten[0].nil?
    return false unless board[row][column].first_move == true && board[row][7]&.first_move == true
    return false unless board[row][column + 1 ].nil? && board[row][column + 2 ].nil?
    return false unless check_for_checks(color,  board, mock = true, piece_position, [row, column + 1]).flatten[0].nil?
    return false unless check_for_checks(color,  board, mock = true, piece_position, [row, column + 2]).flatten[0].nil?
    true   
  end

  def castling_left?(piece, board = game.board, piece_position = piece.piece_position)

    color = piece.color
    row = piece_position[0]
    column = piece_position[1]

    return false unless check_for_checks(color, board, false).flatten[0].nil?
    return false unless board[row][column].first_move == true && board[row][0]&.first_move == true 
    return false unless board[row][column - 1 ].nil? && board[row][column - 2 ].nil?
    return false unless board[row][column - 3 ].nil?
    return false unless check_for_checks(color,  board, mock = true, piece_position, [row, column - 1]).flatten[0].nil?
    return false unless check_for_checks(color,  board, mock = true, piece_position, [row, column - 2]).flatten[0].nil?
    true   
  end

  def castling(piece, board = game.board, piece_position = piece.piece_position)

    castling_array = []
    
    castling_array << [ piece_position[0], piece_position[1] + 2, :castling_right ] if castling_right?(piece, board, piece_position) 
    castling_array << [ piece_position[0], piece_position[1] - 2, :castling_left ] if castling_left?(piece, board, piece_position)
    castling_array
  end
end

