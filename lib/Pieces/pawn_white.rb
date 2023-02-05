# frozen_string_literal: true

class WhitePawn < Piece
  def initialize(sign: '♙', position: [nil])
    @sign = sign
    @color = 'white'
    @position = position
  end

  def illegal?(board, start_row, start_column, end_row, end_column)
    if [end_row, end_column] == [start_row + 1, start_column]
      false
    elsif start_row == 1 && [end_row, end_column] == [start_row + 2, start_column]
      false
    elsif [end_row,
           end_column] == [start_row + 1,
                           start_column + 1] && board[end_row][end_column].sign != ' '
      false
    elsif [end_row,
           end_column] == [start_row + 1,
                           start_column - 1] && board[end_row][end_column].sign != ' '
      false
    else
      true
    end
  end

  # def white_starting_positions(board???)
  # 	starting_position = [1, 1, 1, 1, 1, 1, 1, 1 [0..7]]
  # board[1][1]
  # end
end
