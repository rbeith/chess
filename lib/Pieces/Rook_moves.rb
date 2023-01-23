module Rookmoves
  def conditions(_board, start_row, start_column, end_row, end_column)
    if end_column > start_column || end_column < start_column
      false
    elsif end_row > start_row || end_row < start_row
      false
		else 
			true
    end
  end
end
