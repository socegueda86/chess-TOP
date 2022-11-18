module DrawBoard

  def draw_board_whites_perspective
    row_separator = "  +---+---+---+---+---+---+---+---+"
      @board.reverse.each_with_index do |row, i|
        puts row_separator
        puts "#{ 8 - i } | #{row[0].nil? ? " " : row[0] } | #{row[1].nil? ? " " : row[1] } | #{row[2].nil? ? " " : row[2] } | #{row[3].nil? ? " " : row[3] } | #{row[4].nil? ? " " : row[4] } | #{row[5].nil? ? " " : row[5] } | #{row[6].nil? ? " " : row[6] } | #{row[7].nil? ? " " : row[7] } |"
        end
      puts row_separator
      puts "    A   B   C   D   E   F   G   H  "
  end 

  def draw_board_blacks_perspective
    row_separator = "  +---+---+---+---+---+---+---+---+"
    @board.reverse.each_with_index do |row, i|
      puts row_separator
      puts "#{ i +1 } | #{row[0].nil? ? " " : row[0] } | #{row[1].nil? ? " " : row[1] } | #{row[2].nil? ? " " : row[2] } | #{row[3].nil? ? " " : row[3] } | #{row[4].nil? ? " " : row[4] } | #{row[5].nil? ? " " : row[5] } | #{row[6].nil? ? " " : row[6] } | #{row[7].nil? ? " " : row[7] } |"
      end
    puts row_separator
    puts "    H   G   F   E   D   C   B   A  "
  end

  #erase this method or comment it out
  def debugging_draw_board(board)
    row_separator = "  +---+---+---+---+---+---+---+---+"
      board.reverse.each_with_index do |row, i|
        puts row_separator
        puts "#{ 8 - i } | #{row[0].nil? ? " " : row[0] } | #{row[1].nil? ? " " : row[1] } | #{row[2].nil? ? " " : row[2] } | #{row[3].nil? ? " " : row[3] } | #{row[4].nil? ? " " : row[4] } | #{row[5].nil? ? " " : row[5] } | #{row[6].nil? ? " " : row[6] } | #{row[7].nil? ? " " : row[7] } |"
        end
      puts row_separator
      puts "    A   B   C   D   E   F   G   H  "
  end 

  def create_board
    board = (1..8).map  { |x| Array.new(8) }
    
    row_1 = %w(T H B Q K B H T)
    row_2 = %w(P P P P P P P P)
    row_7 = %w(P P P P P P P P)
    row_8 = %w(T H B Q K B H T)
    
    board[0] = row_1.map.with_index { |element, index| piece_builder(element, @colors[0], [0, index]) }
    board[1] = row_2.map.with_index { |element, index| piece_builder(element, @colors[0], [1, index]) }
    board[6] = row_7.map.with_index { |element, index| piece_builder(element, @colors[1], [6, index]) }
    board[7] = row_8.map.with_index { |element, index| piece_builder(element, @colors[1], [7, index]) }
    
    board
  end

  def piece_builder(element, color, position)

    if element  == 'T'
      Tower.new( color, position)   
    elsif element  == 'H'
      Knight.new( color, position)
    elsif element  == 'B'
      Bishop.new( color, position)
    elsif element  == 'Q'
      Queen.new( color, position)
    elsif element  == 'K'
      King.new( color, position)
    elsif element  == 'P'
      Pawn.new( color, position)
    else
      raise StandardError.new "Problem in the #board_creation"
    end
    
  end 


end
