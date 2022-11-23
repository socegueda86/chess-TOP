require_relative '../lib/king.rb'
require_relative '../lib/chess.rb'
require_relative '../lib/moves_module.rb'
require_relative '../lib/draw_board_module.rb'

RSpec.describe King do

  include MovesModule
  include DrawBoard

  describe '#castling_right?' do
    subject(:b_king) { King.new(:black, [7,4])}
    let(:b_queen) { double('Queen', piece_type: :queen, color: :black,  to_s: 'Q') }
    let(:b_tower_left) { double('Tower Left', piece_type: :tower, color: :black, first_move: true, to_s: 'T') }
    let(:b_tower_right) { double('Tower Right', piece_type: :tower, color: :black, first_move: true,to_s: 'T') }
    
      
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

        result = b_king.castling_right?(board, [7,4])
        expect(result).to be (true)

      end
    end
  end
end
  

