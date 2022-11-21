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
    @players = [player_1_class.new, player_2_class.new]
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
end


class Player;end

class HumanPlayer;end
class ComputerPlayer;end



