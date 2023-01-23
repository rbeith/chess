module Kingmoves
  def conditions(_board, start_row, start_column, end_row, end_column)
    if [end_row, end_column] == [start_row + 1, start_column]
      false
    elsif [end_row, end_column] == [start_row - 1, start_column]
      false
    elsif [end_row, end_column] == [start_row, start_column + 1]
      false
    elsif [end_row, end_column] == [start_row, start_column - 1]
      false
    elsif [end_row, end_column] == [start_row + 1, start_column - 1]
      false
    elsif [end_row, end_column] == [start_row - 1, start_column + 1]
      false
    elsif [end_row, end_column] == [start_row + 1, start_column + 1]
      false
    elsif [end_row, end_column] == [start_row - 1, start_column - 1]
      false
      # king cannot move into check
      # if king in check, must try to get out of check
		else 
			true
    end
  end
end
