require '../lib/chess.rb'
RSpec.describe Game do
  describe '#create_board' do
    let(:double_player_1) { double('Double 1', new: 'double_player_1.new return value')}
    let(:double_player_2) { double('Double 2', new: 'double_player_2.new return value')}
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

  describe '#switch_player' do
    
    let(:double_player_1) { double('Double 1', new: 'double_player_1')}
    let(:double_player_2) { double('Double 2', new: 'double_player_2')}
    subject(:game) {Game.new(double_player_1,double_player_2)}
    

    it 'returns double_player_2 when the current_player is double_player_1' do
      expect{ game.switch_player }.to change{ game.current_player }.from(double_player_1.new).to(double_player_2.new)
    end

    it 'returns double_player_1 when the current_player is double_player_2' do
      game.switch_player
      expect{ game.switch_player }.to change{ game.current_player }.from(double_player_2.new).to(double_player_1.new)
    end

  end

end