require_relative '../lib/moves_module.rb'
require_relative '../lib/draw_board_module.rb'

RSpec.describe 'MovesModule' do

  include MovesModule
  include DrawBoard
  
  
  describe 'castling methods' do
  
  let(:b_queen) { double('Queen', piece_type: :queen, color: :black,  to_s: 'Q') }
  let(:b_tower_left) { double('Tower Left', piece_type: :tower, color: :black, first_move: true, to_s: 'T') }
  let(:b_tower_right) { double('Tower Right', piece_type: :tower, color: :black, first_move: true,to_s: 'T') }
  let(:b_king) { double('King Black', piece_type: :king, color: :black, first_move: true, piece_position: [7,4], to_s: 'K') }
    
    context "when castling_right? is called and the conditions allows it" do
      let(:board) do
        board = (1..8).map  { |x| Array.new(8, nil) }
        board[7][0] = b_tower_left
        board[7][3] = b_queen
        board[7][4] = b_king
        board[7][7] = b_tower_right
        board
      end

      it "should return true to the castling" do

        result = castling_right?(board, [7,4])
        expect(result).to be (true)

      end
    end
  end
end


#let(:b_bishop) { double('Bishop', piece_type: :bishop, color: :black) }
#  let(:b_knight) { double('Knight', piece_type: :knight, color: :black) }
#  let(:b_queen) { double('Queen', piece_type: :queen, color: :black) }
#  let(:b_pawn) { double('Pawn', piece_type: :pawn, color: :black) }
#  let(:b_tower_left) { double('Tower', piece_type: :tower, color: :black, first_move: :true) }
#  let(:b_tower_right) { double('Tower', piece_type: :tower, color: :black, first_move: :true) }
#  let(:b_king) { double('King Black', piece_type: :king, color: :black, first_move: :true) }
#  let(:w_king) { double('King White', piece_type: :king, color: :white, first_move: :true) }