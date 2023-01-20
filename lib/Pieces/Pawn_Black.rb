class BlackPawn < Piece
	attr_reader :sign, :white

	def initialize(sign = '♟︎')
		@sign = sign
		@moved = false
	end

	def moved?
		@moved = true
	end

	def forbidden?(from, to, board)
		p from
		p to
		case 
		when [to[0], to[1]] == [from[0]-1, from[1]]
			false
		when [to[0], to[1]] == [from[0]-2, from[1]] && from[0] == 6
			false
		when [to[0], to[1]] == [from[0]-1, from[1]+1] && board[to[0]][to[1]] != self.sign && board[to[0]][to[1]] != ' '
			false
		when [to[0], to[1]] == [from[0]-1, from[1]-1] && board[to[0]][to[1]] != self.sign && board[to[0]][to[1]] != ' '
			false
		else
			true
		end
	end


	# def black_starting_positions
	# 	starting_position = [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
	# end

end

	