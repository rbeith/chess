module Queenmoves
  def conditions(_board, start_row, start_column, end_row, end_column)
    dx = (end_column - start_column).abs
    dy = (end_row - start_row).abs

    if dx == dy && dx > 0
      false
    elsif end_column > start_column || end_column < start_column
      false
    elsif end_row > start_row || end_row < start_row
      false
    end
  end
end
