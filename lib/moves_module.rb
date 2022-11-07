module MovesModule

  DIRECTIONS_HASH = {up_right: [1, 1], down_right: [-1, 1], up_left: [1, -1],
    down_left: [-1, -1], down: [-1, 0], up: [1, 0], left: [0, -1],
    right: [0, -1], horse_up_right: [2, 1], horse_right_up: [1, 2],
    horse_right_down: [-1, 2], horse_down_right: [-2, 1], horse_down_left: [-2, -1],
    horse_left_down: [-1, -2], horse_left_up: [-2, 1], horse_up_left: [-1, -2]}

 def posible_moves_q_t_b(direction)
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

 #this hash return the correspondent summands in order to check the next square in the specified direction
 
 DIRECTIONS_HASH.fetch(direction)
   
   
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