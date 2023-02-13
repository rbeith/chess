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
        allow(movement).to receive(:check?).and_return nil
        movement.move_piece(player1)
        expect(movement.board[2][0].sign).to eq(' ♙ ')
      end

      it 'resets the previous space' do
        allow(player1).to receive(:piece).and_return([1, 0])
        allow(player1).to receive(:space).and_return([2, 0])
        allow(movement).to receive(:check?).and_return nil
        movement.move_piece(player1)
        expect(movement.board[1][0].sign).to eq('   ')
      end

      it 'updates #@position of piece' do
        allow(player1).to receive(:piece).and_return([1, 0])
        allow(player1).to receive(:space).and_return([2, 0])
        allow(movement).to receive(:check?).and_return nil
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

    describe '#king_move_blocked' do
      it 'declares true if king cannot move without being in check' do
        check.board = Array.new(3, Array.new(3, Piece.new))
        king = check.board[0][1] = WhiteKing.new(position: [0, 1])
        check.board[0][0] = WhitePawn.new(position: [0, 0])
        check.board[1][0] = WhitePawn.new(position: [1, 0])
        check.board[0][2] = WhitePawn.new(position: [0, 2])
        check.attacker_path = [[1, 1]]
        check.board[2][2] = BlackQueen.new(position: [2, 2])
        expect(check.king_move_blocked?(king)).to be true
      end
    end

    describe '#check' do
      it 'declares check true' do
        check.board = Array.new(3, Array.new(3, Piece.new))
        king = check.board[1][0] = BlackKing.new(position: [1, 0])
        check.instance_variable_set(:@black_king, king)
        name = 'PLAYER'
        check.instance_variable_set(:@current_player, :name)
        rook = check.board[1][2] = WhiteRook.new(position: [1, 2])
        expect(check.check?(rook)).to be true
      end
    end

    describe '#checkmate?' do
      it 'declares checkmate when no piece can block move to king space' do
        check.board = Array.new(3, Array.new(3, Piece.new))
        check.board[0][0] = WhiteKing.new
        king = check.board[0][0]
        king.update_position(0, 0)
        check.attacker_path = [[1, 1]]
        check.board[2][2] = BlackQueen.new
        queen = check.board[2][2]
        queen.update_position(2, 2)
        check.check_blocking_pieces?(king)
        expect(check.check_blocking_pieces?(king)).to be true
      end

      it 'does not declare checkmate when piece can block move to king space' do
        check.board = Array.new(4, Array.new(4, Piece.new))
        king = check.board[0][0] = WhiteKing.new
        king.update_position(0, 0)
        pawn = check.board[0][1] = WhitePawn.new
        pawn.update_position(0, 1)
        queen = check.board[3][3] = BlackQueen.new
        queen.update_position(3, 3)
        check.attacker_path = [[1, 1], [2, 2]]
        expect(check.check_blocking_pieces?(king)).to be false
      end
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

    it 'allows a black pawn to move' do
      board = allowed_movement.board
      piece = board[6][0]
      expect(allowed_movement.forbidden?([6, 0], [4, 0], piece)).to be false
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

    it 'accepts a two character input and returns array coordinates' do
      expect(inputs.board_location('b1')).to eq([0, 1])
    end
  end

  describe '#select_piece' do
    subject(:piece) { described_class.new }

    it 'allows user to select piece and returns board coordinates' do
      allow(piece).to receive(:gets).and_return('b1')
      input = piece.select_piece
      expect(piece.board_location(input)).to eq([0, 1])
    end
  end

  describe '#select_space' do
    subject(:space) { described_class.new }

    it 'allows user to select space and returns board coordinates' do
      allow(space).to receive(:gets).and_return('b1')
      input = space.select_space
      expect(space.board_location(input)).to eq([0, 1])
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

describe BlackPawn do
  subject(:pawn_movement) { described_class.new }

  describe '#illegal?' do
    board = []

    it 'allows legal move' do
      expect(pawn_movement.illegal?(board, 6, 3, 4, 3)).to be false
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
