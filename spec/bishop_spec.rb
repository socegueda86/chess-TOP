require '../lib/bishop.rb'
require '../lib/chess.rb'

RSpec.describe Bishop do
  
  describe '#inside_the_board' do
    
    context 'when initial position is [3,3]' do
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( game,:white,[3,3])} 

      it 'returns false when it goes one square up and right' do
        expect(bishop.next_move_inside_the_board?(3,3,:up_right)).to be true
      end
    end

    context 'when initial position is [7,7]' do
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( game,:white,[7,7])} 
    
      it 'returns true when it goes one square up and right' do
        expect(bishop.next_move_inside_the_board?(7,7,:up_right)).to be false
      end
    end
  end
    
  describe '#available_moves' do

    context 'When the bishop is at [0,0]' do
      board = (1..8).map  { |x| Array.new(8) }
      let(:game) { double('Game Double', board: board)}
      subject(:bishop) { Bishop.new( game, :white, [3,3])}

      it 'returns the an arrray with all posible squares to move' do
        expect(bishop.available_moves[0]).to contain_exactly([0,0],[1,1],[2,2],[4,4],[5,5],[6,6],[7,7],[0,6],[1,5],[2,4],[4,2],[5,1],[6,0])
      end
    end
  
  end

  describe '#same_color_piece?' do
    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :white)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( game, :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.same_color_piece?(5,4)).to be true
      end
    end

    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :black)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( game, :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.same_color_piece?(5,4)).to be false
      end
    end
  end

  describe '#opponent_color_piece?' do
    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :white)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( game, :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.opponent_color_piece?(5,4)).to be false
      end
    end

    context 'when it recieves the same color' do
      
      let(:square) { double('square double', color: :black)}
      board = (1..6).map  { |x| Array.new(5) }
      let(:game) { double('Game Double', board: board, color: :white)}
      subject(:bishop) { Bishop.new( game, :white, [3,3]) }

      it 'returns true' do
        board[5][4] = square
        expect(bishop.opponent_color_piece?(5,4)).to be true
      end
    end
  end

  #describe '#opponent_color_piece?' do
  #  
  #end

end




