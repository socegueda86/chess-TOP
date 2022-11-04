Module DrawBoard

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
 
#def draw_board_only_player2_is_humanM; end


end
