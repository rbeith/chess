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

	def first_move?
		@first_move = true
	end

	def forbidden?(from, to, board)
		
		case 
		when board[to[0]][to[1]] == ' '
			true
		when [to[0], to[1]] == [from[0]+1, from[1]]
			false
		when board[to[0]][to[1]] == self.sign
			false
		else
			true
		end
		#may move two spaces in the same column on the first move/from the start position
		#location of piece in column + 1
		#unless first move (@first??) 
		# or just when not on starting position? 

	end

	# def white_starting_positions(board???)
	# 	starting_position = [1, 1, 1, 1, 1, 1, 1, 1 [0..7]]
	  # board[1][1]
	# end

	# def black_starting_positions
	# 	starting_position = [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
	# end

	
end

	