module Bishopmoves
  def conditions(board, start_row, start_column, end_row, end_column)
    dx = (end_column - start_column).abs
    dy = (end_row - start_row).abs

    if dx == dy && dx > 0
      false
      # add iterator to check each space along the way
		else 
			true
    end
  end
end
