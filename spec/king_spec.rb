require_relative '../lib/king.rb'
require_relative '../lib/chess.rb'
require_relative '../lib/moves_module.rb'
require_relative '../lib/draw_board_module.rb'

RSpec.describe King do

  include MovesModule
  include DrawBoard

  describe 'Castling Methods' do
    subject(:b_king) { King.new(:black, [7,4])}
    let(:b_queen) { double('Black Queen', piece_type: :queen, color: :black,  to_s: '♕') }
    let(:b_tower_left) { double('Black Tower Left', piece_type: :tower, color: :black, first_move: true, to_s: '♖') }
    let(:b_tower_right) { double('Black Tower Right', piece_type: :tower, color: :black, first_move: true,to_s: '♖') }
    let(:b_bishop) { double('Black Bishop', piece_type: :bishop, color: :black, to_s: '♗') }
    let(:b_knight) { double('Black Knight', piece_type: :knight, color: :black, to_s: '♘') }
    let(:b_pawn) { double('Black Pawn', piece_type: :pawn, color: :black, to_s: '♙') }
        
    let(:w_king) { King.new(:white, [0,4]) }
    let(:w_tower_left) { double('White Tower Left', piece_type: :tower, color: :white, first_move: true, to_s: '♜') }
    let(:w_tower_right) { double('White Tower Right', piece_type: :tower, color: :white, first_move: true, to_s: '♜') }
    let(:w_queen) { double('White Queen', piece_type: :queen, color: :white, to_s: '♛') }
    let(:w_bishop) { double('White Bishop', piece_type: :bishop, color: :white, to_s: '♝') }
    let(:w_knight) { double('White Knight', piece_type: :knight, color: :white, to_s: '♞') }
    let(:w_pawn) { double('White Pawn', piece_type: :pawn, color: :white, to_s: '♟︎') }
      
    context "when castling_right? is called and theres no pieces obstructing right-castling, but queens obstruct left castling" do
      let(:board) do
        board = (1..8).map  { |x| Array.new(8, nil) }
        board[7][0] = b_tower_left
        board[7][3] = b_queen
        board[7][4] = b_king
        board[7][7] = b_tower_right
        board
      end
  
      it "should return true to castling_right?" do
        result = b_king.castling_right?(board, [7,4])
        expect(result).to be (true)
      end

      it "should return false to the castling_left?" do
        result = b_king.castling_left?(board, [7,4])
        expect(result).to be (false)
      end
    end

    context "when castling_left? is called and theres no pieces obstructing left-castling, but knight obstruct left castling" do
      let(:board) do
        board = (1..8).map  { |x| Array.new(8, nil) }
        board[0][0] = w_tower_left
        board[0][6] = w_knight
        board[0][4] = w_king
        board[0][7] = w_tower_right
        debugging_draw_board(board)
        board
      end

      it "should return true to castling_left?" do
        result = w_king.castling_left?(board, [0,4])
        expect(result).to be (true)
      end


      it "should return true to castling_left?" do
        result = w_king.castling_right?(board, [0,4])
        expect(result).to be (false)
      end

    end
  end
end
  

