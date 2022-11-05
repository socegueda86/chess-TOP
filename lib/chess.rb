require_relative 'pieces.rb'
require_relative 'draw_board_module.rb'
require_relative 'knight.rb'
require_relative 'tower.rb'
require_relative 'bishop.rb'
require_relative 'pawn.rb'
require_relative 'queen.rb'
require_relative 'king.rb'



class Game
  include DrawBoard
  attr_reader :current_player
  
  def initialize(player_1_class, player_2_class)
    @board = create_board()
    @players = [player_1_class.new, player_2_class.new]
    @white_pieces = @players[rand(0..1)]
    @current_player = @white_pieces
  end

  
  def create_board
    board = (1..8).map  { |x| Array.new(8) }
    
    board = (1..8).map  { |x| Array.new(8) }
    
    row_1 = %w(T H B Q K B H T)
    row_2 = %w(P P P P P P P P)
    row_7 = %w(P P P P P P P P)
    row_8 = %w(T H B Q K B H T)
    
    board[0] = row_1.map.with_index { |element, index| piece_builder(element, 'white', [0, index]) }
    board[1] = row_2.map.with_index { |element, index| piece_builder(element, 'white', [1, index]) }
    board[6] = row_7.map.with_index { |element, index| piece_builder(element, 'black', [6, index]) }
    board[7] = row_8.map.with_index { |element, index| piece_builder(element, 'black', [7, index]) }
    
    board
  end

  def piece_builder(element, color, pos)

    if element  == 'T'
      Tower.new( self, color,pos)   
    elsif element  == 'H'
      Knight.new( self, color, pos)
    elsif element  == 'B'
      Bishop.new( self, color, pos)
    elsif element  == 'Q'
      Queen.new( self, color, pos)
    elsif element  == 'K'
      King.new( self, color, pos)
    elsif element  == 'P'
      Pawn.new( self, color, pos)
    else
      raise StandardError.new "Problem in the #board_creation"
    end
  end 

  # will create test when i have added the pieces icons pending
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



game = Game.new(HumanPlayer,HumanPlayer)
game.draw_board
#game.switch_player
#game.draw_board