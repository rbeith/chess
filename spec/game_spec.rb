Dir['/home/magnus/odinproject/ruby/ruby_projects/chess/lib/*'].each { |file| require file }

describe Node do
  subject(:step_finder) { described_class.new }
  let(:knight) { instance_double('knight') }
  describe '#knight_moves' do
    xit 'prints knights moves when given starting position' do
      possible_moves([3, 3], [4, 3], knight.moves)
      expect(possible_moves([3, 3], [4, 3], knight.moves)).to eq([[3, 3], [4, 5], [2, 4], [4, 3]])
    end
  end
end

describe Game do
  describe '#move_piece' do
    subject(:movement) { described_class.new }

    describe '#move_piece' do
      it 'moves a game piece to a new space' do
        from = [1, 0]
        to = [2, 0]
        movement.game_board.move_piece(from, to)
        expect(movement.game_board.board[2][0].sign).to eq('♙')
      end
    end
  end

  describe '#kill_piece' do
    subject(:killer) { described_class.new }
    it 'deletes a piece if taken by another player' do
      killer.game_board.move_piece([6, 1], [2, 0])
      expect(killer.game_board.board[2][0].sign).to eq('♟︎')
    end
  end
end

describe Board do
  subject(:movement) { described_class.new }
  describe '#move_piece' do
    it 'moves a game piece to a new space' do
      from = [1, 0]
      to = [2, 0]
      movement.move_piece(from, to)
      expect(movement.board[2][0].sign).to eq('♙')
    end

    it 'resets the previous space' do
      from = [1, 0]
      to = [2, 0]
      movement.move_piece(from, to)
      expect(movement.board[1][0].sign).to eq(' ')
    end
  end
end

describe Player do
  subject(:inputs) { described_class.new }

  describe '#board_location' do
    it 'accepts a two character input and retuns array coordinates' do
      allow(inputs).to receive(:gets).and_return('b1')
      expect(inputs.board_location).to eq([1, 0])
    end
  end

  describe '#select_piece' do
    it 'allows user to select space and returns board coordinates' do
      allow(inputs).to receive(:gets).and_return('b1')
      inputs.select_piece
      expect(inputs.board_location).to eq([1, 0])
    end
  end

  describe '#select_space' do
    it 'allows user to select space and returns board coordinates' do
      allow(inputs).to receive(:gets).and_return('b1')
      inputs.select_space
      expect(inputs.board_location).to eq([1, 0])
    end
  end
end
