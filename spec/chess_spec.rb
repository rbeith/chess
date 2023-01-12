require_relative '../lib/piece'
require_relative '../lib/node'
require_relative '../lib/board'
require_relative '../lib/pawn'
require_relative '../lib/game'

describe Node do
	subject(:step_finder) { described_class.new }
	let(:knight) {instance_double('knight')}
	describe '#knight_moves' do
		xit 'prints knights moves when given starting position' do
			possible_moves([3, 3], [4, 3], knight.moves)
			expect(possible_moves([3, 3], [4, 3], knight.moves)).to eq([[3,3],[4,5],[2,4],[4,3]])
		end
	end
end

describe Game do
	
	# describe '#new_board' do
	# 	subject(:new_game_setup) { described_class.new }
	# 	# let(:board) { instance_double('board')}

	# 	xit 'places the pawns on the empty spaces' do
	# 		@board = Board.new
	# 		new_game_setup.new_board(@board.board)
	# 		expect(@board.board[1][0].sign).to eq('♙')
	# 	end
	# end

	describe '#move_piece' do
		subject(:movement) { described_class.new }

		# before do
		# 	movement.game_board.new_board
		# end

		# describe '#move_piece' do
		# 	it 'moves a game piece to a new space' do
		# 		from = [1, 0]
		# 		to = [2, 0]
		# 		movement.game_board.move_piece(from, to)
		# 		expect{ movement.game_board.move_piece(from, to) }.to change { movement.game_board.board[2][0].sign }.to('♙')
		# 		movement.game_board.move_piece(from, to)
		# 	end
		# end
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
