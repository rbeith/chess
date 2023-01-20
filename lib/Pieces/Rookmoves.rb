module Rookmoves
	def forbidden?(from, to, board)
		start_row = from[0]
		start_column = from[1]
	  end_row = to[0]
	  end_column = to[1]

		case
		when board[to[0]][to[1]].sign != ' '
		 	true
		when 
			false
			#add iterator to check each space along the way
		else
			true
		end
	end
end
