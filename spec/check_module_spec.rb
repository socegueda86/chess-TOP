require_relative '../lib/check_module.rb'


RSpec.describe 'check_module.rb' do
  include ChecksModule
  include MovesModule
  describe '#kings_position' do
 
    let(:pawn) { double('Pawn', piece_type: :pawn) }
    let(:w_king) { double('King ', piece_type: :king, color: :white) }
    let(:b_king) { double('King ', piece_type: :king, color: :black) }
    let(:board) do
      board = (1..8).map  {|x| Array.new(8, pawn) }
      board[2][5] = w_king
      board[5][6] = b_king
      board
    end

    let(:test_board) { double('Board', board: board)  }
      
    it "returns a hash with kings positions" do 
      result = kings_position(board)
    expect(result).to include(:white => [2,5], :black =>[5,6])

    end
  end

  describe "check_4_checks_pawns" do
    
    let(:w_pawn) { double('Pawn', piece_type: :pawn, color: :white) }
    let(:b_pawn) { double('Pawn', piece_type: :pawn, color: :black) }
    let(:w_king) { double('King White', piece_type: :king, color: :white) }
    let(:b_king) { double('King Black', piece_type: :king, color: :black) }
    
    let(:board) do
      board = (1..8).map  {|x| Array.new(8, nil) }
      board[2][5] = w_king
      board[5][6] = b_king
      [[1,6],[4,5],[4,7],[3,4],[3,6]].each { |square| board[square[0]][square[1]] = b_pawn }
      board[6][5] = w_pawn
      board 
    end

    it 'returns no positions when :black is used in check_4_checks_pawns' do 
      
      result = check_4_checks_pawns(board, :black)
      expect(result).to eq([])
    end

    it 'returns an array of the pawns that create a check when :white is used in check_4_checks_pawns'  do
      result = check_4_checks_pawns(board, :white)
      expect(result).to contain_exactly([3, 4, b_pawn],[3, 6, b_pawn])
    end
  end

  describe "check_4_checks_by_direction with a white king and all-other black pieces" do


    let(:b_tower) { double('Tower', piece_type: :tower, color: :black) }
    let(:b_bishop) { double('Bishop', piece_type: :bishop, color: :black) }
    let(:b_knight) { double('Knight', piece_type: :knight, color: :black) }
    let(:b_queen) { double('Queen', piece_type: :queen, color: :black) }
    let(:b_pawn) { double('Pawn', piece_type: :pawn, color: :black) }
    let(:b_king) { double('King Black', piece_type: :king, color: :black) }
    let(:w_king) { double('King White', piece_type: :king, color: :white) }

    let(:board) do
      board = (1..8).map  { |x| Array.new(8, nil) }
      [[5,1],[5,3],[3,1],[1,7], [5,5]].each { |square| board[square[0]][square[1]] = b_queen }
      [[7,1],[1,2],[1,5]].each { |square| board[square[0]][square[1]] = b_bishop }
      [[0,7],[3,7],[3,5]].each { |square| board[square[0]][square[1]] = b_tower }
      board[3][3] = w_king
      board[2][2] = b_king 
      [[2,3],[5,4]].each { |square| board[square[0]][square[1]] = b_knight }
      [[4,4]].each { |square| board[square[0]][square[1]] = b_pawn }
      board 
    end
    
    context "When it uses DIAGONAL directions" do
      it 'returns the posible checks in diagonal direction' do
        
        direction = :up_right
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :white)
        expect(result).to contain_exactly()
      end

      it 'returns the posible checks in :down_right diagonal direction' do
        direction = :down_right
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :white)
        expect(result).to contain_exactly([1, 5, b_bishop])
      end

      it 'returns the posible checks in :up_left diagonal direction' do
        direction = :up_left
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :white)
        expect(result).to contain_exactly([5, 1, b_queen])
      end

      it 'returns the posible checks in :down_left diagonal direction' do
        direction = :down_left
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :white)
        expect(result).to contain_exactly([2, 2, b_king])
      end
    end

    context "When it uses vertical and horizotal directions" do
      it 'returns the posible checks in the :up direction' do
        direction = :up
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :white)
        expect(result).to contain_exactly([5, 3, b_queen])
      end

      it 'returns the posible checks in the :down direction' do
        direction = :down
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :white)
        expect(result).to contain_exactly()
      end

      it 'returns the posible checks in the :down direction' do
        direction = :right
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :white)
        expect(result).to contain_exactly([3, 5, b_tower])
      end

      it 'returns the posible checks in the :down direction' do
        direction = :left
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :white)
        expect(result).to contain_exactly([3, 1, b_queen])
      end


    end
  end


  describe "check_4_checks_by_direction with a black king and all-other white pieces" do

    let(:w_tower) { double('Tower', piece_type: :tower, color: :white) }
    let(:w_bishop) { double('Bishop', piece_type: :bishop, color: :white) }
    let(:w_knight) { double('Knight', piece_type: :knight, color: :white) }
    let(:w_queen) { double('Queen', piece_type: :queen, color: :white) }
    let(:w_pawn) { double('Pawn', piece_type: :pawn, color: :white) }
    let(:w_king) { double('King Black', piece_type: :king, color: :white ) }
    let(:b_king) { double('King White', piece_type: :king, color: :black) }

    let(:board) do
      board = (1..8).map  { |x| Array.new(8, nil) }
      [[5,1],[5,3],[3,1],[1,7], [5,5]].each { |square| board[square[0]][square[1]] = w_queen }
      [[7,1],[1,2],[1,5]].each { |square| board[square[0]][square[1]] = w_bishop }
      [[0,7],[3,7],[3,5]].each { |square| board[square[0]][square[1]] = w_tower }
      board[3][3] = b_king
      board[2][2] = w_king 
      [[2,3],[5,4]].each { |square| board[square[0]][square[1]] = w_knight }
      [[4,4]].each { |square| board[square[0]][square[1]] = w_pawn }
      board 
    end
    
    context "When it uses DIAGONAL directions" do
      
 
  
      it 'returns the posible checks in diagonal direction' do
        
        direction = :up_right
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :black)
        expect(result).to contain_exactly()
      end

      it 'returns the posible checks in :down_right diagonal direction' do
        direction = :down_right
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :black)
        expect(result).to contain_exactly([1, 5, w_bishop])
      end

      it 'returns the posible checks in :up_left diagonal direction' do
        direction = :up_left
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :black)
        expect(result).to contain_exactly([5, 1, w_queen])
      end

      it 'returns the posible checks in :down_left diagonal direction' do
        direction = :down_left
        result = check_4_checks_by_direction(direction, board, [:bishop, :queen, :king], :black)
        expect(result).to contain_exactly([2, 2, w_king])
      end
    end

    context "When it uses vertical and horizotal directions" do
      it 'returns the posible checks in the :up direction' do
        direction = :up
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :black)
        expect(result).to contain_exactly([5, 3, w_queen])
      end

      it 'returns the posible checks in the :down direction' do
        direction = :down
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :black)
        expect(result).to contain_exactly()
      end

      it 'returns the posible checks in the :down direction' do
        direction = :right
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :black)
        expect(result).to contain_exactly([3, 5, w_tower])
      end

      it 'returns the posible checks in the :down direction' do
        direction = :left
        result = check_4_checks_by_direction(direction, board, [:tower, :queen, :king], :black)
        expect(result).to contain_exactly([3, 1, w_queen])
      end
    end
  end



  describe "pseudo_board_creator" do

    context "When a board is given" do

     let(:w_tower) { double('Tower', piece_type: :tower, color: :white) }
     let(:w_bishop) { double('Bishop', piece_type: :bishop, color: :white) }
     let(:w_knight) { double('Knight', piece_type: :knight, color: :white) }
     let(:w_queen) { double('Queen', piece_type: :queen, color: :white) }
     let(:w_pawn) { double('Pawn', piece_type: :pawn, color: :white) }
     let(:w_king) { double('King Black', piece_type: :king, color: :white ) }
     let(:b_king) { double('King White', piece_type: :king, color: :black) }
 
     let(:board) do
       board = (1..8).map  { |x| Array.new(8, nil) }
       [[5,1],[5,3],[3,1],[1,7], [5,5]].each { |square| board[square[0]][square[1]] = w_queen }
       [[7,1],[1,2],[1,5]].each { |square| board[square[0]][square[1]] = w_bishop }
       [[0,7],[3,7],[3,5]].each { |square| board[square[0]][square[1]] = w_tower }
       board[3][3] = b_king
       board[2][2] = w_king 
       [[2,3],[5,4]].each { |square| board[square[0]][square[1]] = w_knight }
       [[4,4]].each { |square| board[square[0]][square[1]] = w_pawn }
       board 
     end
 
     it "returns a deep copy of the array" do
       result = pseudo_board_creator(board)
       expect(result).to eq(board)
     end
   end
  end

  describe "board_if_piece_moved" do

    context "When a board and a move are given" do
 
     let(:w_tower) { double('Tower', piece_type: :tower, color: :white) }
     let(:w_bishop) { double('Bishop', piece_type: :bishop, color: :white) }
     let(:w_knight) { double('Knight', piece_type: :knight, color: :white) }
     let(:w_queen) { double('Queen', piece_type: :queen, color: :white) }
     let(:w_pawn) { double('Pawn', piece_type: :pawn, color: :white) }
     let(:w_king) { double('King White', piece_type: :king, color: :white ) }
     let(:b_king) { double('King Black', piece_type: :king, color: :black) }
 
     let(:board) do
       board = (1..8).map  { |x| Array.new(8, nil) }
       [[5,1],[5,3],[3,1],[1,7], [5,5]].each { |square| board[square[0]][square[1]] = w_queen }
       [[7,1],[1,2],[1,5]].each { |square| board[square[0]][square[1]] = w_bishop }
       [[0,7],[3,7],[3,5]].each { |square| board[square[0]][square[1]] = w_tower }
       board[3][3] = b_king
       board[2][2] = w_king 
       [[2,3],[5,4]].each { |square| board[square[0]][square[1]] = w_knight }
       [[4,4]].each { |square| board[square[0]][square[1]] = w_pawn }
       board 
     end
 
      it "move the piece to the new location" do

        board_if_piece_moved(board, [3,3], [2,3])

        expect(board[2][3]).to eq(b_king)
      end
    end
  end

end



