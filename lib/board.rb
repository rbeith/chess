class Board
	attr_accessor :board

	def initialize
		@board = Array.new(8) { Array.new(8, Piece.new) }
		@board[0][0] = Rook.new('♖')
		@board[0][1] = Bishop.new('♗')
		@board[0][2] = Knight.new('♘')
		@board[0][3] = Queen.new('♕')
		@board[0][4] = King.new('♔')
		@board[0][5] = Knight.new('♘')
		@board[0][6] = Bishop.new('♗')
		@board[0][7] = Rook.new('♖')
		@board[1].map! { |i| i = Pawn.new('♙') }
		@board[6].map! { |i| i = Pawn.new('♟︎') }
		@board[7][0] = Rook.new('♜')
		@board[7][1] = Bishop.new('♝')
		@board[7][2] = Knight.new('♞')
		@board[7][3] = Queen.new('♛')
		@board[7][4] = King.new('♚')
		@board[7][5] = Knight.new('♞')
		@board[7][6] = Bishop.new('♝')
		@board[7][7] = Rook.new('♜')
	end

	def draw_board
		<<-BOARD
                    1   2   3   4   5   6   7   8 
		a | #{@board[0][0].sign} | #{@board[0][1].sign} | #{@board[0][2].sign} | #{@board[0][3].sign} | #{@board[0][4].sign} | #{@board[0][5].sign} | #{@board[0][6].sign} | #{@board[0][7].sign} |
		  ---------------------------------
		b | #{@board[1][0].sign} | #{@board[1][1].sign} | #{@board[1][2].sign} | #{@board[1][3].sign} | #{@board[1][4].sign} | #{@board[1][5].sign} | #{@board[1][6].sign} | #{@board[1][7].sign} |
		  ---------------------------------
		c | #{@board[2][0].sign} | #{@board[2][1].sign} | #{@board[2][2].sign} | #{@board[2][3].sign} | #{@board[2][4].sign} | #{@board[2][5].sign} | #{@board[2][6].sign} | #{@board[2][7].sign} |
		  ---------------------------------
		d | #{@board[3][0].sign} | #{@board[3][1].sign} | #{@board[3][2].sign} | #{@board[3][3].sign} | #{@board[3][4].sign} | #{@board[3][5].sign} | #{@board[3][6].sign} | #{@board[3][7].sign} |
		  ---------------------------------
		e | #{@board[4][0].sign} | #{@board[4][1].sign} | #{@board[4][2].sign} | #{@board[4][3].sign} | #{@board[4][4].sign} | #{@board[4][5].sign} | #{@board[4][6].sign} | #{@board[4][7].sign} |
		  ---------------------------------
		f | #{@board[5][0].sign} | #{@board[5][1].sign} | #{@board[5][2].sign} | #{@board[5][3].sign} | #{@board[5][4].sign} | #{@board[5][5].sign} | #{@board[5][6].sign} | #{@board[5][7].sign} |
		  ---------------------------------
		g | #{@board[6][0].sign} | #{@board[6][1].sign} | #{@board[6][2].sign} | #{@board[6][3].sign} | #{@board[6][4].sign} | #{@board[6][5].sign} | #{@board[6][6].sign} | #{@board[6][7].sign} |
		  ---------------------------------
		h | #{@board[7][0].sign} | #{@board[7][1].sign} | #{@board[7][2].sign} | #{@board[7][3].sign} | #{@board[7][4].sign} | #{@board[7][5].sign} | #{@board[7][6].sign} | #{@board[7][7].sign} |
		  ---------------------------------
		BOARD
	end

	# def move_piece(player, from = player.select_piece, to = player.select_space)
	# 	return if @board[to[0]][to[1]].forbidden?(@board[from[0]][from[1]])

	# 	@board[to[0]][to[1]] = @board[from[0]][from[1]]
	# 	@board[from[0]][from[1]] = Piece.new
	# end

	def move_piece(player, from = player.select_piece, to = player.select_space)
		@board[to[0]][to[1]] = @board[from[0]][from[1]]
		@board[from[0]][from[1]] = Piece.new
	end
end