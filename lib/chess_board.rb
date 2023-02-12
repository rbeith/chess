# frozen_string_literal: true

# Starting piece positions for Chess
module ChessBoard
  attr_reader :white_king,
              :black_king

  # TODO: piece should be piece. instance variable not needed as assigned to @board?
  # Will require changes to tests.
  def new_board
    @board = Array.new(8) { Array.new(8, Space.new(piece: Piece.new)) }
		@board.flatten.each { |i| number = 1}
		place_pieces
  end

  def place_pieces
    @board[0][0].piece = WhiteRook.new(position: [0, 0])
    @board[0][1].piece = WhiteKnight.new(position: [0, 1])
    @board[0][2].piece = WhiteBishop.new(position: [0, 2])
    @board[0][3].piece = WhiteQueen.new(position: [0, 3])
    @board[0][4].piece = @white_king = WhiteKing.new(position: [0, 4])
    @board[0][5].piece = WhiteBishop.new(position: [0, 5])
    @board[0][6].piece = WhiteKnight.new(position: [0, 6])
    @board[0][7].piece = WhiteRook.new(position: [0, 7])
    @board[1][0].piece = WhitePawn.new(position: [1, 0])
    @board[1][1].piece = WhitePawn.new(position: [1, 1])
    @board[1][2].piece = WhitePawn.new(position: [1, 2])
    @board[1][3].piece = WhitePawn.new(position: [1, 3])
    @board[1][4].piece = WhitePawn.new(position: [1, 4])
    @board[1][5].piece = WhitePawn.new(position: [1, 5])
    @board[1][6].piece = WhitePawn.new(position: [1, 6])
    @board[1][7].piece = WhitePawn.new(position: [1, 7])
    @board[6][0].piece = BlackPawn.new(position: [6, 0])
    @board[6][1].piece = BlackPawn.new(position: [6, 1])
    @board[6][2].piece = BlackPawn.new(position: [6, 2])
    @board[6][3].piece = BlackPawn.new(position: [6, 3])
    @board[6][4].piece = BlackPawn.new(position: [6, 4])
    @board[6][5].piece = BlackPawn.new(position: [6, 5])
    @board[6][6].piece = BlackPawn.new(position: [6, 6])
    @board[6][7].piece = BlackPawn.new(position: [6, 7])
    @board[7][0].piece = BlackRook.new(position: [7, 0])
    @board[7][1].piece = BlackKnight.new(position: [7, 1])
    @board[7][2].piece = BlackBishop.new(position: [7, 2])
    @board[7][3].piece = BlackQueen.new(position: [7, 3])
    @board[7][4].piece = @black_king = BlackKing.new(position: [7, 4])
    @board[7][5].piece = BlackBishop.new(position: [7, 5])
    @board[7][6].piece = BlackKnight.new(position: [7, 6])
    @board[7][7].piece = BlackRook.new(position: [7, 7])
		puts "num: #{@board[7][7].number}"
  end
end
