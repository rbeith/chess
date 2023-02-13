# frozen_string_literal: true

# Starting piece positions for Chess
module ChessBoard
  attr_reader :white_king,
              :black_king

  # TODO: piece should be piece. instance variable not needed as assigned to @board?
  # Will require changes to tests.
  def new_board
    @board = Array.new(8) { Array.new(8, Piece.new) }
    place_pieces
  end

  def place_pieces
    @board[0][0] = WhiteRook.new(position: [0, 0])
    @board[0][1] = WhiteKnight.new(position: [0, 1])
    @board[0][2] = WhiteBishop.new(position: [0, 2])
    @board[0][3] = WhiteQueen.new(position: [0, 3])
    @board[0][4] = @white_king = WhiteKing.new(position: [0, 4])
    @board[0][5] = WhiteBishop.new(position: [0, 5])
    @board[0][6] = WhiteKnight.new(position: [0, 6])
    @board[0][7] = WhiteRook.new(position: [0, 7])
    @board[1][0] = WhitePawn.new(position: [1, 0])
    @board[1][1] = WhitePawn.new(position: [1, 1])
    @board[1][2] = WhitePawn.new(position: [1, 2])
    @board[1][3] = WhitePawn.new(position: [1, 3])
    @board[1][4] = WhitePawn.new(position: [1, 4])
    @board[1][5] = WhitePawn.new(position: [1, 5])
    @board[1][6] = WhitePawn.new(position: [1, 6])
    @board[1][7] = WhitePawn.new(position: [1, 7])
    @board[6][0] = BlackPawn.new(position: [6, 0])
    @board[6][1] = BlackPawn.new(position: [6, 1])
    @board[6][2] = BlackPawn.new(position: [6, 2])
    @board[6][3] = BlackPawn.new(position: [6, 3])
    @board[6][4] = BlackPawn.new(position: [6, 4])
    @board[6][5] = BlackPawn.new(position: [6, 5])
    @board[6][6] = BlackPawn.new(position: [6, 6])
    @board[6][7] = BlackPawn.new(position: [6, 7])
    @board[7][0] = BlackRook.new(position: [7, 0])
    @board[7][1] = BlackKnight.new(position: [7, 1])
    @board[7][2] = BlackBishop.new(position: [7, 2])
    @board[7][3] = BlackQueen.new(position: [7, 3])
    @board[7][4] = @black_king = BlackKing.new(position: [7, 4])
    @board[7][5] = BlackBishop.new(position: [7, 5])
    @board[7][6] = BlackKnight.new(position: [7, 6])
    @board[7][7] = BlackRook.new(position: [7, 7])
  end
end
