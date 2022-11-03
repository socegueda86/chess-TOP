Rspec.describe Game
  describe '#create_board' do
    let(:double_player_1) { double()}
    let(:double_player_2) { double()}
    subject(:game) {Game.new(double_player_1,double_player_2)}
    it 'Creates an Array with 8 elements' do
      board = game.instance_variable_get(:@board)
      length = board.length
      expect(length).to eql(8)
    end

    it 'Creates an Array with 8 elements, each with its own 8 nil elements' do
      board = game.instance_variable_get(:@board)
      result = board.all? { |row| row.length == 8 }
      expect(result).to be true
    end

  end

end