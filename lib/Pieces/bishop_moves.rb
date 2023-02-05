# frozen_string_literal: true

# Bishop specific movement conditions
module Bishopmoves
  def illegal?(_board, start_row, start_column, end_row, end_column)
    dx = (end_column - start_column).abs
    dy = (end_row - start_row).abs

    if dx == dy && dx.positive?
      false
    else
      true
    end
  end
end
