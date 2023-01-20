module Kingmoves 

	def conditions(board, start_row, start_column, end_row, end_column)
		case
		when board[end_row][end_column].sign != ' '
			true
		when [end_row, end_column] == [start_row+1, start_column]
			false
		when [end_row, end_column] == [start_row-1, start_column]
			false
		when [end_row, end_column] == [start_row, start_column+1]
			false
		when [end_row, end_column] == [start_row, start_column-1]
			false
		when [end_row, end_column] == [start_row+1, start_column-1]
			false
		when [end_row, end_column] == [start_row-1, start_column+1]
			false
		when [end_row, end_column] == [start_row+1, start_column+1]
			false
		when [end_row, end_column] == [start_row-1, start_column-1]
			false
		else
			true
			#king cannot move into check
			#if king in check, must try to get out of check
		end
	end
end