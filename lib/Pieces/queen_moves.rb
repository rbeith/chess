# frozen_string_literal: true

# contains conditions for the movement of the Queen piece.
module Queenmoves
  def conditions(_board, start_row, start_column, end_row, end_column)
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

  def path_empty?(position, destination, direction, board)
		row = position[0]
    col = position[1]
    case direction
    when :up
      (row - 1..destination[0]).each do |i|
				p [[i], [col]]
        return false if board[i][col].sign != ' '
      end
    when :down
      (row + 1..destination[0]).each do |i|
				p board[i][col]
        return false if board[i][col].sign != ' '
      end
    when :left
      (col - 1..destination[1]).each do |j|
        return false if board[row][j].sign != ' '
      end
    when :right
      (col + 1..destination[1]).each do |j|
        return false if board[row][j].sign != ' '
      end
    when :up_left
      i = row - 1
      j = col - 1
      while i <= destination[0] && j <= destination[1]
        return false if board[i][j].sign != ' '

        i -= 1
        j -= 1
      end
    when :up_right
      i = row - 1
      j = col + 1
      while i <= destination[0] && j >= destination[1]
				p board[i][j]
        return false if board[i][j].sign != ' '

        i -= 1
        j += 1
      end
    when :down_left
      i = row + 1
      j = col - 1
      while i < destination[0] && j >= destination[1]
        return false if board[i][j].sign != ' '

        i += 1
        j -= 1
      end
    when :down_right
      i = row + 1
      j = col + 1
      while i < destination[0] && j < destination[1]
        return false if board[i][j].sign != ' '

        i += 1
        j += 1
      end
    end
    true
  end

end
