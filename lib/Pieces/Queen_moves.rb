module Queenmoves
	
	def conditions(board, start_row, start_column, end_row, end_column)
		dx = (end_column - start_column).abs
		dy = (end_row - start_row).abs
			
		case
		when board[end_row][end_column].sign != ' '
		  true
		when dx == dy && dx > 0
			false
		when end_column > start_column || end_column < start_column
			false
		when end_row > start_row || end_row < start_row
			false
		else
			true
		end
	end

end