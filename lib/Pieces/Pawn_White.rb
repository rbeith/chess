class WhitePawn < Piece
	attr_reader :sign, :white

	def initialize(sign = '♙')
		@sign = sign
		@moved = false
	end

	def moved?
		@moved = true
	end

	def forbidden?(from, to, board)
		case 
		when [to[0], to[1]] == [from[0]+1, from[1]]
			false
		when [to[0], to[1]] == [from[0]+2, from[1]] && from[0] == 1
			false
		when [to[0], to[1]] == [from[0]+1, from[1]+1] && board[to[0]][to[1]] != self.sign && board[to[0]][to[1]] != ' '
			false
		when [to[0], to[1]] == [from[0]+1, from[1]-1] && board[to[0]][to[1]] != self.sign && board[to[0]][to[1]] != ' '
			false
		else
			true
		end
	end

	# def white_starting_positions(board???)
	# 	starting_position = [1, 1, 1, 1, 1, 1, 1, 1 [0..7]]
	  # board[1][1]
	# end

end

	