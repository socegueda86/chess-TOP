require_relative 'pieces.rb'
require_relative 'draw_board_module.rb'
require_relative 'tower.rb'
require_relative 'king.rb'
require_relative 'queen.rb' 
require_relative 'pawn.rb'
require_relative 'bishop.rb'
require_relative 'knight.rb'
require_relative 'moves_module.rb'
require_relative 'check_module.rb'

# I still need to solve yf the


class Game
  include DrawBoard
  include MovesModule

  attr_reader :current_player, :board, :kings
  
  def initialize(player_1_class, player_2_class)
    @colors = [:white, :black]
    @board = create_board()
    @players = [player_1_class.new(self, @colors[0]), player_2_class.new(self, @colors[1])]
    @white_pieces = @players[0] #@players[rand(0..1)] I need to correct the rspec so it acepts :rand but returns 1
    @current_player = @white_pieces
    @kings = { white: @board[0][4], black: @board[7][4] }  ## when it moves it should update the position
    @moves = []
  end

  def draw_board     
    if @players[0].class == ComputerPlayer && @players[1].class == HumanPlayer
      draw_board_blacks_perspective
    else
      draw_board_whites_perspective
    end
  end

  def switch_player
    @current_player = @players[new_index]
  end

  def new_index
    return 1 if @players.find_index(@current_player) == 0
    return 0 if @players.find_index(@current_player) == 1
  end

  def play # pending to finish and to test
    intro 
    draw_board
    while true || draw_check
      @current_player.move
      check_for_checks
      break if check_for_win == true
      switch_player
    end
  end
end


class Player

end

class HumanPlayer

  COLUMNS_EQUIVALENT = {A: 0, B: 1, C: 2, D: 3, E: 4, F: 5, G: 6, H: 7} 

  def initialize(game, color)
    @game = game
    @color = color
  end

  def move # pending to test
    from_to_array = []
  
    loop do
      loop do
        users_input = get_users_input(:from)
        break from_to_array << users_input if valid_users_input?(users_input, :from)
        puts "Invalid input"
      end
      
      loop do
        users_input = get_users_input(:to)
        break if get_users_input == :q
        return from_to_array << users_input if valid_users_input?(users_input, :to)
        puts "Invalid input"
      end
    end
  end

  def get_users_input(from_to) # pending to test
    loop do
      puts from_to == :from ? "Select a piece by typing the square it is located" : "Select the square where you want to move the piece or press 'Q' to pick other piece" 
      puts "\nEnter your selection by typing the number of the row and the column letter."
      puts "i.e. 1A would point to the square located at row 1, column A."
      users_input = gets
      
      return :q if users_input.match(/^[Qq]$/) && from_to == :to
      return input_to_array_values(users_input) if users_input.match(/^[A-Ha-h][1-8]$/)
      puts "Invalid input.\n"
    end
  end


  def valid_users_input?(users_input, from_to) # pending to test
    
    row = users_input[0]
    column = users_input[1]

    if from_to == :from
      return true unless @game.board[row][column].nil? || @game.board[row][column].color != @color
      false
    end
    ### I AM HERE... WILL FINISH THIS MODULE AND MAKE A COMMIT
    if from_to == :to ;

    end
  end

  def input_to_array_values(users_input)
    row = users_input.split('')[0] - 1
    column = COLUMNS_EQUIVALENT.fetch(users_input.split('')[1].upcase)
    [row, column]
  end
end 


class ComputerPlayer;end



