require_relative '../lib/pawn.rb'
require_relative '../lib/chess.rb'
require_relative '../lib/moves_module.rb'
require_relative '../lib/draw_board_module.rb'


RSpec.describe Pawn do

  include MovesModule
  include DrawBoard
  
  let(:b_pawn_1) { Pawn.new(:black, [6, 0]) }
  let(:b_pawn_2) { Pawn.new(:black, [6, 3]) }
  let(:b_pawn_3) { Pawn.new(:black, [4, 5]) }
  let(:b_pawn_4) { Pawn.new(:black, [3, 6]) }
  let(:b_pawn_5) { Pawn.new(:black, [6, 7]) }
  let(:b_pawn_6) { Pawn.new(:black, [5, 7]) }
  let(:b_pawn_7) { Pawn.new(:black, [2, 3]) }

  let(:w_pawn_1) { Pawn.new(:white, [1,0]) }
  let(:w_pawn_2) { Pawn.new(:white, [2,1]) }
  let(:w_pawn_3) { Pawn.new(:white, [6,2]) }
  let(:w_pawn_4) { Pawn.new(:white, [1,3]) }
  let(:w_pawn_5) { Pawn.new(:white, [4,6]) }
  let(:w_pawn_6) { Pawn.new(:white, [3,7]) }
    
  let(:w_tower) { double('White Tower', piece_type: :tower, color: :white, to_s: '♜') }  #[5,0]
  let(:w_queen) { double('White Queen', piece_type: :queen, color: :white, to_s: '♛') }  #{3,4}
    
  let(:board) do
    board = (1..8).map  { |x| Array.new(8, nil) }
      
    board[6][0] = b_pawn_1
    board[6][3] = b_pawn_2
    board[4][5] = b_pawn_3
    board[3][6] = b_pawn_4
    board[6][7] = b_pawn_5
    board[5][7] = b_pawn_6
    board[2][3] = b_pawn_7

    board[1][0] = w_pawn_1
    board[2][1] = w_pawn_2
    board[6][2] = w_pawn_3
    board[1][3] = w_pawn_4
    board[4][6] = w_pawn_5
    board[3][7] = w_pawn_6
    
    board[5][0] = w_tower
    board[3][4] = w_queen

    
    board
  end
  
  describe "#pawn_forward_move" do
    context "when a black pawn is blocked by an opposite color piece" do
      it "returns an empty array" do
        result = board[6][0].pawn_forward_move(board)
        expect(result). to be()
      end
    

      it "returns an empty array" do
        result = board[1][3].pawn_forward_move(board)
        expect(result).to be()
      end
    end

    context "when the pawn is not blocked and it is on the initial position" do 
      it "returns an array with a one-square movement and a two-square movement" do
        result = board[6][3].pawn_forward_move(board)
        expect(result).to contain_exactly([5,3 ],[4, 3])
      end

      it "returns an array with a one-square movement and a two-square movement" do
        result = board[1][0].pawn_forward_move(board)
        expect(result).to contain_exactly([2,0],[3,0])
      end
    end
    
    context "when the pawn is not blocked and it is not on the initial position" do 
      it "returns an array with a one-square move" do
        result = board[2][1].pawn_forward_move(board)
        expect(result).to contain_exactly([3,1])
      end
    
      it "returns an array with a one-square move" do
        result = board[3][6].pawn_forward_move(board)
        expect(result).to contain_exactly([2,6])
      end
    end
  end

  describe "#pawn_normal_capture" do
    context "when there are opponent pieces on a forward row and on a column to the right AND to the left" do

      it "it should return an array with 2 possible captures" do
        board[5][5] = b_pawn_5
        
        result = board[4][6].pawn_normal_capture(board)
        expect(result).to contain_exactly([5, 7, b_pawn_6],[5, 5, b_pawn_5])
      end

      it "it should return an array with 2 possible captures" do
        board[3][6] = w_pawn_6
        result = board[4][5].pawn_normal_capture(board)
        expect(result).to contain_exactly([3, 6, w_pawn_6],[3, 4, w_queen])
      end
    end

    context "when there is an opponent piece on a forward row and on a column to the right OR to the left" do
      it "it should return an array with 1 possible captures" do
        result = board[4][6].pawn_normal_capture(board)
        expect(result).to contain_exactly([5, 7, b_pawn_6])
      end

      it "it should return an array with 1 possible captures" do
        result = board[4][5].pawn_normal_capture(board)
        expect(result).to contain_exactly([3, 4, w_queen])
      end
    end

    context "when there is no opponent pieces on a forward row and on columns to the right OR to the left" do

      it "it should return an array with 0 possible captures" do
        result = board[6][2].pawn_normal_capture(board)
        expect(result).to contain_exactly()
      end

      it "it should return an array with 0 possible captures" do
        result = board[3][6].pawn_normal_capture(board)
        expect(result).to contain_exactly()
      end
    end
  end

  describe "#en_passant_capture" do
    context "when there is a possible en_passant_capture and last move was [[3,7],:white, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(b_pawn_4).to receive_message_chain(:game, :moves).and_return([[[3,7],:white, :pawn]])

        result = board[3][6].en_passant_capture(board)
        expect(result).to contain_exactly(2, 7, board[3][7])
      end
    end

    context "when there is a possible en_passant_capture and last move was [[4,5], :black, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(w_pawn_5).to receive_message_chain(:game, :moves).and_return([[[4,5], :black, :pawn]])
        result = board[4][6].en_passant_capture(board)
        expect(result).to contain_exactly(5, 5, board[4][5])
      end
    end

    context "when there is a possible en_passant_capture and last move was [[3,7],:white, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(b_pawn_4).to receive_message_chain(:game, :moves).and_return([[[3,7],:white, :knight]])

        result = board[3][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end

    context "when there is a possible en_passant_capture and last move was [[4,5], :black, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(w_pawn_5).to receive_message_chain(:game, :moves).and_return([[[4,5], :black, :queen]])
        result = board[4][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end

    context "when there is a possible en_passant_capture and last move was [[3,7],:white, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(b_pawn_4).to receive_message_chain(:game, :moves).and_return([[[3,6],:white, :pawn]])

        result = board[3][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end

    context "when there is a possible en_passant_capture and last move was [[4,5], :black, :pawn]" do
      it 'returns the array with the possible capture' do
        
        allow(w_pawn_5).to receive_message_chain(:game, :moves).and_return([[[5,5], :black, :pawn]])
        result = board[4][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end
    
    context "when there is a possible en_passant_capture and last move was [[3,7],:white, :pawn]" do
      it 'returns the array with the possible capture' do
          
        allow(b_pawn_4).to receive_message_chain(:game, :moves).and_return([[[3,6],:black, :pawn]])
  
        result = board[3][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end
  
    context "when there is a possible en_passant_capture and last move was [[4,5], :black, :pawn]" do
      it 'returns the array with the possible capture' do
          
        allow(w_pawn_5).to receive_message_chain(:game, :moves).and_return([[[5,5], :white, :pawn]])
        result = board[4][6].en_passant_capture(board)
        expect(result).to be(false)
      end
    end
  end
end

# [ [[row1,col1], color, piece1], [[row2, col2], color, piece2],... [[row_n,col_n], color, piece_n]]