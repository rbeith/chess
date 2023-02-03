module Bishopmoves
	def conditions(_board, start_row, start_column, end_row, end_column)
    p dx = (end_column - start_column).abs
    p dy = (end_row - start_row).abs

    if dx == dy && dx.positive?
      false
		else 
			true
    end
  end
end
