require '../lib/bishop.rb'
require '../lib/chess.rb'

RSpec.describe Bishop do
  
  describe '#inside_the_board' do
    
    context 'when initial position is [3,3]' do
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( :white, [3,3])} 

      it 'returns false when it goes one square up and right' do
        expect(bishop.next_move_inside_the_board?(3,3,:up_right)).to be true
      end
    end

    context 'when initial position is [7,7]' do
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( :white, [7,7])} 
    
      it 'returns true when it goes one square up and right' do
        expect(bishop.next_move_inside_the_board?(7,7,:up_right)).to be false
      end
    end
  end
    
  describe '#available_moves' do

    context 'When the bishop is at [0,0]' do
      DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( :white, [3,3])}

      it 'returns the an arrray with all posible squares to move' do
        expect(bishop.available_moves(board)[0]).to contain_exactly([0,0],[1,1],[2,2],[4,4],[5,5],[6,6],[7,7],[0,6],[1,5],[2,4],[4,2],[5,1],[6,0])
      end
    end

    context 'When is in [5,5] and row 6 is full' do
      DIAGONAL = [:up_right, :down_right, :up_left, :down_left]
      let(:pawn) { double('Pawn Double', color: :black)} 
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( :white, [5,5])}

      it 'returns [6,4] and [6,6]' do
        board[6] = Array.new(8, pawn) 
        expect(bishop.available_moves( board)[1]).to contain_exactly([6,4, pawn], [6,6, pawn])
      end
    end
  end

  describe '#same_color_piece?' do
    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :white)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.same_color_piece?(5, 4, game.board)).to be true
      end
    end

    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :black)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new(  :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.same_color_piece?(5, 4, game.board)).to be false
      end
    end
  end

  describe '#opponent_color_piece?' do
    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :white)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.opponent_color_piece?(5, 4, game.board)).to be false
      end
    end

    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :black)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.opponent_color_piece?(5, 4, game.board)).to be true
      end
    end
  end

  #describe '#opponent_color_piece?' do
  #  
  #end

end




