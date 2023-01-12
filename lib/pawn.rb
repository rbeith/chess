class Pawn < Piece
	attr_reader :sign, :black, :white

	def initialize(sign = ' ')
		@sign = sign
	end

	def black
		@sign = '♟︎'
	end

	def white
		@sign = '♙'
	end

	def forbidden?(from, to, board)
		#if there is a piece on the space in front of the
		#same column on the board, cannot move
		if [to[0], to[1]] != [from[0]+1, from[1]]
			true
		elsif 
			board[to[0]][to[1]] != ' ' || board[to[0]][to[1]] != self.sign
		  true
		else 
			false
		end
		
		#may move diagonally from current position if there is a piece to kill
		#may move two spaces in the same column on the first move/from the start position
		#...
		#location of piece in column + 1
		#unless first move (@first??) 
		#piece in column + 1 + row +||- 1 if
	 	#to loc contains piece
	end

	# def white_starting_positions(board???)
	# 	starting_position = [1, 1, 1, 1, 1, 1, 1, 1 [0..7]]
	  # board[1][1]
	# end

	# def black_starting_positions
	# 	starting_position = [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
	# end

	
end

	