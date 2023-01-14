Dir['./lib/*'].each { |file| require file }
# require '/Users/School/Documents/odinproject/chess/lib/node'

# describe Node do
# 	subject(:step_finder) { described_class.new }
# 	let(:knight) {instance_double('knight')}
# 	describe '#knight_moves' do
# 		xit 'prints knights moves when given starting position' do
# 			possible_moves([3, 3], [4, 3], knight.moves)
# 			expect(possible_moves([3, 3], [4, 3], knight.moves)).to eq([[3,3],[4,5],[2,4],[4,3]])
# 		end
# 	end
# end

describe Game do
	let(:player1) { instance_double('player1') }
	let(:player2) { instance_double('player2') }

	describe '#move_piece' do
		subject(:movement) { described_class.new }

		it 'moves a game piece to a new space' do
			from = [1, 0]
			to = [2, 0]
			movement.game_board.move_piece(player1, from, to)
			expect(movement.game_board.board[2][0].sign).to eq('♙')
		end
	end

	describe '#kill_piece' do
		subject(:killer) { described_class.new }

		it 'deletes a piece if taken by another player' do
			killer.game_board.move_piece(player2, [6, 1], [2, 0])
			expect(killer.game_board.board[2][0].sign).to eq('♟︎')
		end
	end
end

describe Board do
	subject(:movement) { described_class.new }
	let(:player1) { instance_double('player1')}

	describe '#move_piece' do
		it 'moves a game piece to a new space' do
			from = [1, 0]
			to = [2, 0]
			movement.move_piece(player1, from, to)
			expect(movement.board[2][0].sign).to eq('♙')
		end

		it 'resets the previous space' do
			from = [1, 0]
			to = [2, 0]
			movement.move_piece(player1, from, to)
			expect(movement.board[1][0].sign).to eq(' ')
		end
	end

end

describe Player do
	let(:board) { instance_double('game_board') }
	
	describe '#board_location' do
		subject(:inputs) { described_class.new }

		it 'accepts a two character input and retuns array coordinates' do
			allow(inputs).to receive(:gets).and_return('b1')
			expect(inputs.board_location).to eq([1, 0])
		end
	end

	
	describe '#select_piece' do
		subject(:piece) { described_class.new }

		it 'allows user to select space and returns board coordinates' do
			allow(piece).to receive(:gets).and_return('b1')
			piece.select_piece
			expect(piece.board_location).to eq([1, 0])
		end
	end

	describe '#select_space' do
		subject(:space) { described_class.new }

		it 'allows user to select space and returns board coordinates' do
			allow(space).to receive(:gets).and_return('b1')
			space.select_space
			expect(space.board_location).to eq([1, 0])
		end
	end
end

describe WhitePawn do
	subject(:check_forbidden) { described_class.new }

	
	describe '#forbidden?' do
		before do
			@board = [[0, 1, 2, 3], [0, 1, 2, 3], [0, 1, 2, 3], [0, 1, 2, 3], [0, 1, 2, 3]]
		end

		it 'forbids illegal move' do
			from = [1, 0]
			to = [4, 0]
			expect(check_forbidden.forbidden?(from, to, @board)).to be true
		end

		it 'allows legal move' do
			from = [1, 0]
			to = [2, 0]
			expect(check_forbidden.forbidden?(from, to, @board)).to be false
		end

		it 'allows pawn to attack diagonally' do
			from = [1, 0]
			to = [2, 1]
			expect(check_forbidden.forbidden?(from, to, @board)).to be true
		end

		it 'forbids diagonal attack if space empty' do
			from = [1, 0]
			to = [2, 1]
			expect(check_forbidden.forbidden?(from, to, [[0, 1, 2, 3], [0, 1, 2, 3], [0, ' ', 2, 3], [0, 1, 2, 3]])).to be true
		end
	end
end
