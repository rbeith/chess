module Bishopmoves
	def forbidden?(from, to, board)
		start_row = from[0]
		start_column = from[1]
	  end_row = to[0]
	  end_column = to[1]
		dx = (end_column - start_column).abs
		dy = (end_row - start_row).abs
			
		case
		when board[to[0]][to[1]].sign != ' '
		  true
		when dx == dy && dx > 0
			false
			#add iterator to check each space along the way
		else
			true
		end

	end
end
