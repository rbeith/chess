# frozen_string_literal: true

module Rookmoves
  def illegal?(_board, start_row, start_column, end_row, end_column)
    if end_column > start_column && end_row == start_row
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
