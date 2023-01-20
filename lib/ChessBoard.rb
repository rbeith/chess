class ChessBoard
	attr_reader :piece

	def initialize
		new_board
		place_pieces
	end

	def new_board
		@piece = Array.new(8) { Array.new(8, Piece.new) }
	end

	def place_pieces
		@piece[0][0] = WhiteRook.new
		@piece[0][1] = WhiteBishop.new
		@piece[0][2] = WhiteKnight.new
		@piece[0][3] = WhiteQueen.new
		@piece[0][4] = WhiteKing.new
		@piece[0][5] = WhiteKnight.new
		@piece[0][6] = WhiteBishop.new
		@piece[0][7] = WhiteRook.new
		@piece[1].map! { |i| i = WhitePawn.new }
		@piece[6].map! { |i| i = BlackPawn.new }
		@piece[7][0] = BlackRook.new
		@piece[7][1] = BlackBishop.new
		@piece[7][2] = BlackKnight.new
		@piece[7][3] = BlackQueen.new
		@piece[7][4] = BlackKing.new
		@piece[7][5] = BlackKnight.new
		@piece[7][6] = BlackBishop.new
		@piece[7][7] = BlackRook.new
	end

end
