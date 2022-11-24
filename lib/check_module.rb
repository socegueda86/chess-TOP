
require_relative 'moves_module.rb'

module ChecksModule

  include MovesModule


  # Creates a copy of the board
  def pseudo_board_creator(board)
    pseudo_board = []
    board.each do  |row|
      pseudo_row = []
      
      row.each do |square| 
        pseudo_row << square
      end

      pseudo_board << pseudo_row
    end

    pseudo_board
  end

  def board_if_piece_moved(pseudo_board, from, to) # is_a_castling)
    
    
      pseudo_board[to[0]][to[1]] = pseudo_board[from[0]][from[1]]
      pseudo_board[from[0]][from[1]] = nil
      pseudo_board
  end


  def check_for_checks(color,  board, mock = true, from = nil, to = nil) 
    raise StandardError " 'from' and 'to' variables are are needed if mock == true, check code againg" if mock == true && from == nil && to == nil
    capture = []
    board = mock == true ? board_if_piece_moved( pseudo_board_creator(board), from, to) : board
    
    

    DIAGONAL.each { |direction| capture << check_4_checks_by_direction(direction, board, [:bishop, :queen]) }
    STRAIGHT.each { |direction| capture << check_4_checks_by_direction(direction, board, [:tower, :queen]) }
    (DIAGONAL+ STRAIGHT).each { |direction| capture << check_4_checks_by_direction(direction, board, [:king]) }
    KNIGHT_MOVES.each {|direction| capture << check_4_checks_by_direction(direction, board, [:knight]) }
    capture << check_4_checks_pawns(board, color).flatten(1) unless check_4_checks_pawns(board, color).nil?
  end



  def check_4_checks_by_direction(direction, board, piece_classes, color = self.color)
    row = kings_position(board).fetch(color)[0]
    column = kings_position(board).fetch(color)[1]
    capture_squares = []
  
    while next_move_inside_the_board?(row, column, direction)  #check that row and column are varying and increasing towards outside the board
      row += direction_summands(direction)[0] 
      column += direction_summands(direction)[1]
     
      break if same_color_piece?(row, column, board)
      
      if opponent_color_piece?(row, column, board, color) 
        if piece_classes.include?(board[row][column].piece_type)
          break capture_squares << [row, column, board[row][column]]
        end
        break
      end
      break if piece_classes == [:knight] || piece_classes == [:king] 
    end
     capture_squares
  end
  
  def check_4_checks_pawns(board, color = self.color) 
    
    row = kings_position(board).fetch(color)[0]
    column = kings_position(board).fetch(color)[1]
    capture_array = []
    
    if color == :black
      
      if board[row - 1][column + 1]&.piece_type == :pawn && board[row - 1][column + 1]&.color == :white
        capture_array << [row - 1, column + 1, board[row - 1][column + 1]]
      end
      
      if board[row - 1][column - 1]&.piece_type == :pawn && board[row - 1][column - 1]&.color == :white
        capture_array << [row - 1,column - 1, board[row - 1][column - 1]]
      end
    end

    if color == :white
      if board[row + 1][column + 1]&.piece_type == :pawn && board[row + 1][column + 1]&.color == :black
        capture_array << [row + 1, column + 1, board[row + 1][column + 1]]
      end
      
      if board[row + 1][column - 1]&.piece_type == :pawn && board[row + 1][column - 1]&.color == :black
        capture_array << [row + 1, column - 1, board[row + 1][column - 1]]
      end
    end
      capture_array
  end


  def kings_position(board)
 
    kings_position_hash = {}
  
    board.each_with_index do |row, index_1|
      row.each_with_index do |square, index_2|
        unless square.nil?
          kings_position_hash[square.color] = [index_1, index_2] if square.piece_type == :king
        end
      end
    end
    
    kings_position_hash 
  end
end