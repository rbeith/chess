module Rookmoves
	def conditions(board, start_row, start_column, end_row, end_column)
			
		case
			when board[end_row][end_column].sign != ' '
				true
			when end_column > start_column || end_column < start_column
				false
			when end_row > start_row || end_row < start_row
				false
			else
				true
		end

	end
end
