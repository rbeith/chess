module Rookmoves
  def conditions(board, start_row, start_column, end_row, end_column)
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

	def path_empty?(position, destination, direction, board)
    row = position[0]
    col = position[1]
    case direction
    when :up
      (row - 1..destination[0]).each do |i|
        return false if board[i][col].sign != ' '
      end
    when :down
      (row + 1..destination[0]).each do |i|
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
    end
    true
  end

end
