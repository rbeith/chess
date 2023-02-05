# frozen_string_literal: true

require_relative '../lib/main'

describe Game do
  subject(:movement) { described_class.new }
  let(:player1) { instance_double('player1') }

  describe '#turn' do
    context 'When a player takes a turn' do
      it 'updates the game board' do
        # allow(game).to receive(:get_input).and_return
      end
    end
  end
end

describe Board do
  subject(:movement) { described_class.new }
  let(:player1) { instance_double('player1') }
  let(:player2) { instance_double('player2') }

  describe '#move_piece' do
    context 'When a player moves a piece' do
      it 'moves a game piece to a new space' do
        allow(player1).to receive(:piece).and_return([1, 0])
        allow(player1).to receive(:space).and_return([2, 0])
        movement.move_piece(player1)
        expect(movement.board[2][0].sign).to eq('♙')
      end

      it 'resets the previous space' do
        allow(player1).to receive(:piece).and_return([1, 0])
        allow(player1).to receive(:space).and_return([2, 0])
        movement.move_piece(player1)
        expect(movement.board[1][0].sign).to eq(' ')
      end

      it 'updates #position of piece' do
        allow(player1).to receive(:piece).and_return([1, 0])
        allow(player1).to receive(:space).and_return([2, 0])
        movement.move_piece(player1)
        expect(movement.board[2][0].position).to eq([2, 0])
      end
    end
  end

  describe '#kill_piece' do
    # it 'changes space to self when it takes another piece' do
    #   piece = BlackPawn.new
    #   movement.board[3][1] = piece
    #   allow(player2).to receive(:piece).and_return([3, 1])
    #   allow(player2).to receive(:space).and_return([2, 0])
    #   allow(movement).to receive(:verify_input).and_return(nil)
    #   movement.move_piece(player2)
    #   expect(movement.board[2][0].sign).to eq('♟︎')
    # end
  end

  context 'when a piece is in check' do
    subject(:check) { described_class.new }

    describe '#check' do
      it 'declares check when next move can be to king space' do
        board = Board.new
        pawn = BlackPawn.new
        board.board[1][5] = pawn
        pawn.update_position(1, 5)
        expect(check.check?(pawn)).to be true
      end
    end

    describe '#checkmate?' do
      # it 'declares checkmate when piece can move to king space' do
      #   space = BlackKing.new
      #   expect { check.check_mate?(space) }.to output { 'Checkmate' }.to_stdout
      # end
    end
  end

  describe '#direction' do
    subject(:find_direction) { described_class.new }
    it 'can move up' do
      expect(find_direction.direction([3, 3], [0, 3])).to eq(:up)
    end

    it 'can move down' do
      expect(find_direction.direction([0, 3], [3, 3])).to eq(:down)
    end

    it 'can move right' do
      expect(find_direction.direction([0, 0], [0, 3])).to eq(:right)
    end

    it 'can move left' do
      expect(find_direction.direction([0, 3], [0, 0])).to eq(:left)
    end

    it 'can move up_left' do
      expect(find_direction.direction([3, 3], [0, 0])).to eq(:up_left)
    end

    it 'can move up_right' do
      expect(find_direction.direction([3, 0], [0, 3])).to eq(:up_right)
    end

    it 'can move down_right' do
      expect(find_direction.direction([0, 3], [3, 0])).to eq(:down_left)
    end

    it 'can move down_left' do
      expect(find_direction.direction([0, 0], [3, 3])).to eq(:down_right)
    end
  end

  describe '#path_empty?' do
    subject(:blocked) { described_class.new }

    it 'can move in a straight line when there are no pieces in path' do
      expect(blocked.path_empty?([1, 3], [3, 3])).to be true
    end

    it 'cannot move when a piece is blocking' do
      expect(blocked.path_empty?([0, 3], [3, 3])).to be false
    end
  end

  describe '#forbidden?' do
    subject(:allowed_movement) { described_class.new }

    it 'allows a pawn to move from a starting position' do
      board = allowed_movement.board
      piece = board[1][0]
      expect(allowed_movement.forbidden?([1, 0], [2, 0], piece)).to be false
    end

    it 'does not allow a rook to move with pieces in front' do
      board = allowed_movement.board
      piece = board[0][0]
      expect(allowed_movement.forbidden?([0, 0], [2, 0], piece)).to be true
    end

    it 'does not allow the black queen to move over other pieces' do
      board = allowed_movement.board
      piece = board[7][3]
      expect(allowed_movement.forbidden?([7, 3], [2, 3], piece)).to be true
    end

    it 'does not allow the white queen to move over other pieces' do
      board = allowed_movement.board
      piece = board[0][3]
      expect(allowed_movement.forbidden?([0, 3], [2, 3], piece)).to be true
    end

		context 'When the piece is a Knight' do
			it 'allows the piece to move over other pieces' do
				piece = allowed_movement.board[0][1]
				expect(allowed_movement.forbidden?([0, 1], [2, 0], piece)).to be false
			end
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
  subject(:pawn_movement) { described_class.new }

  describe '#illegal?' do
    board = Array.new(5) { Array.new(4, Piece.new) }

    it 'forbids illegal move' do
      expect(pawn_movement.illegal?(board, 1, 0, 4, 0)).to be true
    end

    it 'allows legal move' do
      expect(pawn_movement.illegal?(board, 1, 0, 2, 0)).to be false
    end

    it 'allows pawn to attack diagonally' do
      board[2][1] = BlackPawn.new
      expect(pawn_movement.illegal?(board, 1, 0, 2, 0)).to be false
    end

    it 'forbids diagonal attack if space empty' do
      expect(pawn_movement.illegal?(board, 2, 1, 3, 2)).to be true
    end
  end
end

describe WhiteKing do
  subject(:king_movement) { described_class.new }
  board = Array.new(4) { Array.new(4, Piece.new) }

  it 'cannot move two spaces' do
    expect(king_movement.illegal?(board, 0, 1, 2, 1)).to be true
  end
end

describe WhiteBishop do
  describe '#illegal?' do
    subject(:bishop_movement) { described_class.new }
    board = Array.new(4) { Array.new(4, Piece.new) }

    it 'can move along a diagonal' do
      expect(bishop_movement.illegal?(board, 0, 0, 3, 3)).to be false
    end

    it 'cannot move along a row' do
      expect(bishop_movement.illegal?(board, 0, 0, 0, 3)).to be true
    end
  end
end

describe WhiteQueen do
  subject(:queen_movement) { described_class.new }
  board = Array.new(4) { Array.new(4, Piece.new) }

  describe '#illegal?' do
    it 'can move straight down a column' do
      expect(queen_movement.illegal?(board, 0, 0, 3, 0)).to be false
    end

    it 'can move along a row' do
      expect(queen_movement.illegal?(board, 0, 0, 0, 3)).to be false
    end

    it 'can move along a diagonal' do
      expect(queen_movement.illegal?(board, 0, 0, 3, 3)).to be false
    end
  end
end

describe WhiteRook do
  subject(:rook_movement) { described_class.new }
  board = Array.new(4) { Array.new(4, Piece.new) }

  describe '#illegal?' do
    it 'can move along a column' do
      expect(rook_movement.illegal?(board, 3, 0, 0, 0)).to be false
    end

    it 'can move along a row' do
      expect(rook_movement.illegal?(board, 0, 0, 0, 3)).to be false
    end

    it 'cannot move along a diagonal' do
      expect(rook_movement.illegal?(board, 0, 0, 3, 3)).to be true
    end
  end
end

describe WhiteKnight do
  subject(:knight_moves) { described_class.new }
  board = nil

  describe '#illegal?' do
    it 'can move +2, +1' do
      expect(knight_moves.illegal?(board, 0, 2, 2, 3)).to be false
    end

    it 'cannot move +2, +2' do
      expect(knight_moves.illegal?(board, 0, 2, 2, 4)).to be true
    end
  end

end


describe Piece do
end
