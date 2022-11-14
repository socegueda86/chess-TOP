module ChecksModule

  def pseudo_board_creator(from, to, piece)
    pseudo_board = []
    @game.board.each do  |row|
      pseudo_square = []
      row.each do |square| 
        pseudo_square << square
      end
      pseudo_board << pseudo_square
    end

    board_if_piece_moved(pseudo_board, from, to, piece)
  end

  def board_if_piece_moved(pseudo_board, from, to, piece)
    pseudo_board[to[0]][to[1]] = piece
    pseudo_board[from[0]][from[1]] = nil
    pseudo_board
  end


def check_for_checks(color, mock = true)
  capture = []
  board = mock == true ? pseudo_board_creator : @game.board
  
  capture << check_4_checks_by_direction(DIAGONAL, board, [Bihop, Queen, King]).flatten(1)
  capture << check_4_checks_by_direction(STRAIGHT, board, [Tower, Queen, King]).flatten(1)
  capture << check_4_checks_by_direction(KNIGHT_MOVES, board, [Knight]).flatten(1)
  capture << check_4_checks_pawns.flatten(1)
end



def check_4_checks_by_direction(direction, board, piece_classes, color)
  row = kings_position.fetch(color)[0]
  column = kings_position.fetch(color)[1]
  capture_squares = []

  while next_move_inside_the_board?(row, column, direction)  #check that row and column are varying and increasing towards outside the board
  
    row += direction_summands(direction)[0] 
    column += direction_summands(direction)[1]

    break if same_color_piece?(row, column, board)
    
    if opponent_color_piece?(row, column, board) 
      if piece_classes.include?(board[row][column].class)
        break capture_squares << [row, column, board[row][column]]
      end
      break
    end

    break if piece_classes == [Knight] 
  end
   capture_squares
end

  def check_4_checks_pawns(board) # falta agregar que tiene que ser peon
    
    row = kings_position.fetch(color)[0]
    column = kings_position.fetch(color)[1]
    capture_array = []
    if self.color == :black
      unless board[row - 1][column + 1].nil?
        capture_array << [row - 1, column + 1, board[row - 1][column + 1]]
      end
      unless board[row - 1][column - 1].nil?
        capture_array << [[row - 1],[column - 1], board[row - 1][column - 1]]
      end
    end

    if self.color == :white
      unless board[row + 1][column + 1].nil?
        capture_array << [[row + 1],[column + 1], board[row + 1][column + 1]]
      end
      unless board[row + 1][column - 1].nil?
        capture_array << [[row + 1],[column - 1], board[row + 1][column - 1]]
      end
    end
  
    capture_array
    end


  def kings_position (board)
    kings_position_hash = {}
  
    kings_position_array = board.each_with_index do |row, index_1|
        row.each_with_index do |square, index_2|
          kings_position_hash[square.color] = [index_1, index_2] if square.class == King 
        end
        
    kings_position_array.each { |king| kings_position_hash [king[0].color][pos]}
    kings_position_hash 
  end

end