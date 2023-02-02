require_relative '../lib/main'

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
  subject(:movement) { described_class.new }
  let(:player1) { instance_double('player1') }
  let(:player2) { instance_double('player2') }

  describe '#move_piece' do
    xit 'moves a game piece to a new space' do
      allow(player1).to receive(:piece).and_return([1, 0])
			allow(player1).to receive(:space).and_return([2, 0])
      # allow(player1).to receive(:input).and_return([2, 0])
      movement.game_board.move_piece(player1)
      expect(movement.game_board.board[2][0].sign).to eq('♙')
    end
  end

  describe '#kill_piece' do
    it 'changes space to self when it takes another piece' do
			piece = BlackPawn.new
      movement.game_board.board[3][1] = piece
      allow(player2).to receive(:piece).and_return([3, 1])
      allow(player2).to receive(:space).and_return([2, 0])
			allow(piece).to receive(:forbidden?).and_return(false)
      movement.game_board.move_piece(player2)
      expect(movement.game_board.board[2][0].sign).to eq('♟︎')
    end
  end
end

describe Board do
  subject(:movement) { described_class.new(board: ChessBoard.new.piece) }
  let(:player1) { instance_double('player1') }

  describe '#move_piece' do
    xit 'moves a game piece to a new space' do
      allow(player1).to receive(:piece).and_return([1, 0])
      allow(player1).to receive(:space).and_return([2, 0])
      movement.move_piece(player1)
      expect(movement.board[2][0].sign).to eq('♙')
    end

    xit 'resets the previous space' do
      allow(player1).to receive(:piece).and_return([1, 0])
      allow(player1).to receive(:space).and_return([2, 0])
      movement.move_piece(player1)
      expect(movement.board[1][0].sign).to eq(' ')
    end

		xit 'updates #position of piece' do
			movement.move_piece(player1, [1, 0], [2, 0])
			expect(movement.board[2][0].position).to eq([2, 0])
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
      allow(space).to receive(:gets).and_return('a1')
      space.select_piece
      allow(space).to receive(:gets).and_return('b1')
      space.select_space
      expect(space.board_location).to eq([1, 0])
    end
  end
end

describe WhitePawn do
  subject(:check_forbidden) { described_class.new }
	
  describe '#forbidden?' do
		board = Array.new(5) { Array.new(4, Piece.new) }

    xit 'forbids illegal move' do
      from = [1, 0]
      to = [4, 0]
      expect(check_forbidden.forbidden?(from, to, board)).to be true
    end

    xit 'allows legal move' do
      from = [1, 0]
      to = [2, 0]
      expect(check_forbidden.forbidden?(from, to, board)).to be false
    end

    xit 'allows pawn to attack diagonally' do
			from = [1, 0]
			board[2][1] = BlackPawn.new
			board[2][1]
      to = [2, 1]
      expect(check_forbidden.forbidden?(from, to, board)).to be false
    end

    xit 'forbids diagonal attack if space empty' do
      from = [2, 1]
      to = [3, 2]
      expect(check_forbidden.forbidden?(from, to, board)).to be true
    end
  end
end

describe WhiteKing do
  subject(:king) { described_class.new }

  xit 'cannot move when there is a piece in front of it' do
    from = [0, 1]
    to = [1, 1]
    board = [[0, 1, 2], [0, WhitePawn.new, 2]]
    expect(king.forbidden?(from, to, board)).to be true
  end
end

describe WhiteBishop do
	
	describe '#conditions' do
  subject(:check_conditions) { described_class.new }
	board = Array.new(4) { Array.new(4, Piece.new) }

		it 'returns false if move is legal' do
			expect(check_conditions.conditions(board, 0, 0, 3, 3)).to be false
		end
	end

	describe '#forbidden?' do 

		context 'When the board is empty' do
		subject(:diagonal) { described_class.new }
		board = Array.new(4) { Array.new(4, Piece.new) }

			it 'can move along a diagonal' do
				allow(diagonal).to receive(:check?).and_return(false)
				from = [0, 0]
				to = [3, 3]
				expect(diagonal.forbidden?(from, to, board)).to be false
			end

			it 'cannot move along a row' do
				from = [0, 0]
				to = [0, 3]
				expect(diagonal.forbidden?(from, to, board)).to be true
			end

		end

		context 'When a piece is blocking the path' do
	  subject(:blocked) { described_class.new }
    board = Array.new(4) { Array.new(4, Piece.new) }

			it 'cannot move through an occupied space' do
				from = [0, 0]
				to = [3, 3]
				board[2][2] = WhitePawn.new
				expect(blocked.forbidden?(from, to, board)).to be true
			end

		end
	end	

	describe '#path_empty?' do
		subject(:blocked) { described_class.new }
    board = Array.new(4) { Array.new(4, Piece.new) }

		it 'cannot move through an occupied space' do
			from = [0, 0]
			to = [3, 3]
			board[2][2] = WhitePawn.new
			direction = blocked.direction(from, to)
			expect(blocked.path_empty?(from, to, direction, board)).to be true
		end
	end

end

describe WhiteQueen do
  subject(:queen) { described_class.new }
  board = Array.new(4) { Array.new(4, Piece.new) }

	# describe '#forbidden' do 
	# 	it 'can move straight down a column' do
	# 		from = [0, 0]
	# 		to = [3, 0]
	# 		expect(queen.forbidden?(from, to, board)).to be false
	# 	end

	# 	it 'can move along a row' do
	# 		from = [0, 0]
	# 		to = [0, 3]
	# 		expect(queen.forbidden?(from, to, board)).to be false
	# 	end

	# 	it 'can move along a diagonal' do
	# 		from = [0, 0]
	# 		to = [3, 3]
	# 		expect(queen.forbidden?(from, to, board)).to be false
	# 	end
	# end

	 describe '#path_empty?' do 
	# 	context 'When checking a path for blocking pieces' do
			
	# 		it 'can move in a straight line when there are no pieces in path' do
	# 			expect(queen.path_empty?([0, 3], [3, 3], :down, board)).to be true
	# 		end

	# 		it 'cannot move when a piece is blocking' do
	# 			board[2][3] = WhitePawn.new
	# 			expect(queen.path_empty?([0, 3], [3, 3], :down, board)).to be false
	# 		end

	# 		it 'can move up' do
	# 			expect(queen.path_empty?([3,3], [0,3], :up, board)).to be true
	# 		end
		
	# 		it 'can move up_left' do
	# 			expect(queen.path_empty?([3,3], [0,0], :up_left, board)).to be true
	# 		end

	# 		it 'can move up_right' do
	# 			expect(queen.path_empty?([3,0], [0,3], :up_right, board)).to be true
	# 		end
			
	# 		it 'can move down_right' do
	# 			expect(queen.path_empty?([0,3], [3,0], :down_right, board)).to be true
	# 		end

	# 		it 'can move down_left' do
	# 			expect(queen.path_empty?([0,3], [3,3], :down_left, board)).to be true
	# 		end
	# 	end

		context 'When a piece is blocking the path' do
			subject(:blocked) { described_class.new }
			board = Array.new(4) { Array.new(4, Piece.new) }
			board[2][2] = WhitePawn.new
	
				it '#forbidden? returns true' do
					from = [0, 0]
					to = [3, 3]
					expect(blocked.forbidden?(from, to, board)).to be true
				end

				it '#path_empty? returns true?????' do
					from = [0, 0]
					to = [3, 3]
					p direction = blocked.direction(from, to)
					# direction should be :down_left?
					expect(blocked.path_empty?(from, to, direction, board)).to be true
				end
	
			end
	end

end

describe WhiteRook do
  subject(:rook) { described_class.new }
  board = Array.new(4) { Array.new(4, Piece.new) }

	describe '#path_empty?' do
		context 'when direction is :up' do
			it 'returns true' do
				expect(rook.path_empty?([3, 0], [0, 0], :up, board)).to be true
			end
		end

		context 'when using #direction' do
			it 'returns true' do
				from = [3, 0]
				to = [0, 0]
				direction = rook.direction(from, to)
				expect(rook.path_empty?(from, to, direction, board)).to be true
			end
		end

		context 'when direction is :down' do 
			it 'returns true' do
				from = [0, 0]
			  to = [3, 0]
			  expect(rook.path_empty?(from, to, :down, board)).to be true
			end
		end

		context 'when using #direction' do 
			it 'returns true' do
				from = [0, 0]
			  to = [3, 0]
				direction = rook.direction(from, to)
			  expect(rook.path_empty?(from, to, direction, board)).to be true
			end
		end
	end

	describe '#forbidden?' do
		it 'can move straight down a column' do
			from = [0, 0]
			to = [3, 0]
		  expect(rook.forbidden?(from, to, board)).to be false
		end

		it 'cannot move along a diagonal' do
			from = [0, 0]
			to = [3, 3]
			expect(rook.conditions(board, from[0], from[1], to[0], to[1])).to be true
		end

		it 'cannot move along a diagonal' do
			from = [0, 0]
			to = [3, 3]
			expect(rook.forbidden?(from, to, board)).to be true
		end
	end
end

describe Piece do
	context "when a piece is in check" do
	subject(:check) { described_class.new }

		describe '#check' do
			xit 'declares check when next move can be to king space' do 
				board = Board.new
				pawn = BlackPawn.new
				board.board[1][5] = pawn
				pawn.update_position(1, 5)
				expect(check.check?(pawn, board)).to be true
			end
		end

		describe "#checkmate?" do
			xit 'declares checkmate when piece can move to king space' do
				space = BlackKing.new
				expect{ check.check_mate?(space) }.to output{ "Checkmate" }.to_stdout
			end
		end
	end

end