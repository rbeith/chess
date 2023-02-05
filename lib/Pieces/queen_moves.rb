# frozen_string_literal: true

# contains conditions for the movement of the Queen pieces.
module Queenmoves
  def illegal?(_board, start_row, start_column, end_row, end_column)
    dx = (end_column - start_column).abs
    dy = (end_row - start_row).abs

    if dx == dy && dx.positive?
      false
    elsif end_column > start_column && end_row == start_row
      false
    elsif end_column < start_column && end_row == start_row
      false
    elsif end_row > start_row && end_column == start_column
      false
    elsif end_row < start_row && end_column == start_column
      false
    else
      true
    end
  end
end
