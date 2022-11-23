
RSpec.describe 'MovesModule' do
  describe 'castling methods?' do
    let(:b_tower) { double('Tower', piece_type: :tower, color: :black) }
    let(:b_bishop) { double('Bishop', piece_type: :bishop, color: :black) }
    let(:b_knight) { double('Knight', piece_type: :knight, color: :black) }
    let(:b_queen) { double('Queen', piece_type: :queen, color: :black) }
    let(:b_pawn) { double('Pawn', piece_type: :pawn, color: :black) }
    let(:b_king) { double('King Black', piece_type: :king, color: :black) }
    let(:w_king) { double('King White', piece_type: :king, color: :white) }

    context 'when theres no check or pieces in between' do
      let(:board) do
        board = (1..8).map  { |x| Array.new(8, nil) }
        board[0][0] = b_tower
        board[0][3] = b_queen
        board[0][4] = b_king
        board[0][7] = b_towe
      end
    end
  end
end