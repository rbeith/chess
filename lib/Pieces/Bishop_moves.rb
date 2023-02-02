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

	def path_empty?(position, destination, direction, board)
    row = position[0]
    col = position[1]
    case direction
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
