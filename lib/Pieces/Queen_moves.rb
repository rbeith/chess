module Queenmoves
	
	def forbidden?(from, to, board)
		start_row = from[0]
		start_column = from[1]
	  end_row = to[0]
	  end_column = from[1]

		case
		when board[to[0]][to[1]].sign != ' '
			true
			#add iterator to check each space along the way
		when end_column > start_column
			false
		when end_column < start_column
			false
		when end_row > start_row
			false
		when end_row < start_row
			false
		when end_row > start_row && end_column > start_column
			false
		when end_row < start_row && end_column < start_column
			false
		when end_row > start_row && end_column < start_column
			false
		when end_row < start_row && end_column > start_column
			false
		else
			true
		end
	end

end