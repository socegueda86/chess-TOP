require_relative 'pieces.rb'
require_relative 'draw_board_module.rb'

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

    board[0] = [Tower.new( self, 'white'), Knight.new( self, 'white'), Bishop.new( self, 'white'),
                Queen.new( self, 'white'),King.new( self, 'white'), Bishop.new( self, 'white'),
                Knight.new( self, 'white'), Tower.new( self, 'white')]

    board[1] = [Pawn.new(self, 'white'), Pawn.new(self, 'white'), Pawn.new(self, 'white'), 
                Pawn.new(self, 'white'), Pawn.new(self, 'white'), Pawn.new(self, 'white'), 
                Pawn.new(self, 'white'), Pawn.new(self, 'white')]
    
    board[8] = [Tower.new( self, 'black'), Knight.new( self, 'black'), Bishop.new( self, 'black'),
                Queen.new( self, 'black'),King.new( self, 'black'), Bishop.new( self, 'black'),
                Knight.new( self, 'black'), Tower.new( self, 'black')]
    
    board[7] = [Pawn.new(self, 'black'), Pawn.new(self, 'black'), Pawn.new(self, 'black'), 
                Pawn.new(self, 'black'), Pawn.new(self, 'black'), Pawn.new(self, 'black'), 
                Pawn.new(self, 'black'), Pawn.new(self, 'black')]

    board
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

game.switch_player

game.draw_board