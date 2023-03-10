# frozen_string_literal: true

# Black Pawn class with movement conditions
class BlackPawn < Piece
  def initialize(sign: '♟︎', position: [nil])
    super
    @sign = sign
    @color = 'black'
    @position = position
  end

  def illegal?(board, start_row, start_column, end_row, end_column)
    if [end_row, end_column] == [start_row - 1, start_column]
      false
    elsif start_row == 6 && [end_row, end_column] == [start_row - 2, start_column]
      false
    elsif [end_row,
           end_column] == [start_row - 1,
                           start_column + 1] && board[end_row][end_column].sign != ' '
      false
    elsif [end_row,
           end_column] == [start_row - 1,
                           start_column - 1] && board[end_row][end_column].sign != ' '
      false
    else
      true
    end
  end

  # def black_starting_positions
  # 	starting_position = [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
  # end
end
