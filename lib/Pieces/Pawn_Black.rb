class BlackPawn < Piece
  attr_reader :sign, :white

  def initialize(sign = '♟︎')
    @sign = sign
    @moved = false
  end

  def moved?
    @moved = true
  end

  def conditions(board, start_row, start_column, end_row, end_column)
    if [end_row, end_column] == [start_row - 1, start_column]
      false
    elsif [end_row, end_column] == [start_row - 2, start_column] && start_row == 6
      false
    elsif [end_row,
           end_column] == [start_row - 1,
                           start_column + 1] && board[end_row][end_column] != sign && board[end_row][end_column] != ' '
      false
    elsif [end_row,
           end_column] == [start_row - 1,
                           start_column - 1] && board[end_row][end_column] != sign && board[end_row][end_column] != ' '
      false
    else
      true
    end
  end

  # def black_starting_positions
  # 	starting_position = [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
  # end
end
