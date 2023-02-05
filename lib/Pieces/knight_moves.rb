# frozen_string_literal: true

module KnightMoves
	def illegal?(_board, start_row, start_column, end_row, end_column)
		case [end_row, end_column]
	  when [start_row + 2, start_column + 1]
			false
		when [start_row + 2, start_column - 1]
	    false
	  when [start_row - 2, start_column + 1]
			false
		when [start_row - 2, start_column - 1]
			false
		when [start_row + 1, start_column + 2]
		  false
		when [start_row + 1, start_column - 2]
		  false
		when [start_row - 1, start_column + 2]
		  false
		when [start_row - 1, start_column -2]
			false
	  else
    	true
		end
  end
end
