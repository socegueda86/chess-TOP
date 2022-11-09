class Pawn < Pieces
  
  def initialize(game, color, piece_position, number_move = [1,2])
    @game = game
    @color = color
    @icon = icon_define
    @piece_position
    @first_move = first_move
    @number_move = number_move
  end

  def to_s
    @icon 
  end

  def pawn_moves
    row = @piece_position[0]
    column = @piece_position[1]
    free_squares = []
    capture_squares = []

    free_squares << normal_move unless normal_move(row, column).nil?
    free_squares << double_square_first_move unless @number_move(row, column).lenght == 2 &&  double_square_first_move(row, column).nil?
    capture_squares << normal_capture(row, column) unless normal_capture(row, column).nil?
    capture_squares << en_passant_capture(row, column) unless row != 4 ||  en_passant_capture(row, column).nil? 
  end

  def normal_move(row, column)
    return nil unless check_for_checks(row + 1, column)
    return [[row + 1],[column]]  if @game.board[row + 1][column].nil?
  end

  def double_square_first_move(row, column)
        return nil unless @game.board[row + 1][column].nil? 
        return nil unless check_for_checks(row + 2, column)
        return nil unless @game.board[row + 2][column].nil?
        return [[row + 2],[column]]
      end
    end
    nil
  end
  
  def normal_capture(row, column)
    capture_array = []
    unless check_for_checks(row, column)
      capture_array << [row + 1, column + 1] unless  check_for_checks(row +1, column + 1) || @game.board[row + 1][column + 1].nil? || @game.board[row + 1][column + 1].color == @color 
      capture_array << [row + 1, column - 1] unless  check_for_checks(row +1, column - 1) || @game.board[row + 1][column - 1].nil? || @game.board[row + 1][column - 1].color == @color
      retun capture_array
    end
    nil
  end

  def en_passant_capture(row, column)
    capture_array = []
    unless check_for_checks(row, column)
      capture_array << [row + 1, column + 1] unless  check_for_checks(row +1, column + 1) || @game.board[row + 1][column + 1].nil? || @game.board[row + 1][column + 1].color == @color 
      capture_array << [row + 1, column - 1] unless  check_for_checks(row +1, column - 1) || @game.board[row + 1][column - 1].nil? || @game.board[row + 1][column - 1].color == @color
      retun capture_array
    end
    nil
  end

  
end
