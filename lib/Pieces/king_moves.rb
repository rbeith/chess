# frozen_string_literal: true

# Movement conditions for Kings
module Kingmoves
  def possible_moves
    possible_moves = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
  end

  def illegal?(_board, start_row, start_column, end_row, end_column)
    case [end_row, end_column]
    when [start_row + 1, start_column]
      false
    when [start_row - 1, start_column]
      false
    when [start_row, start_column + 1]
      false
    when [start_row, start_column - 1]
      false
    when [start_row + 1, start_column - 1]
      false
    when [start_row - 1, start_column + 1]
      false
    when [start_row + 1, start_column + 1]
      false
    when [start_row - 1, start_column - 1]
      false
      # king cannot move into check
      # if king in check, must try to get out of check
    else
      true
    end
  end
end
