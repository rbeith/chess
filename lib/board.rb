# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'check'

# class for game board and movement behavior that is not piece specific
# keeps track of piece location
class Board
  include ChessBoard
  include Check

  attr_accessor :board, :attacker_path, :forbidden
  attr_reader :white_king, :black_king, :piece, :checkmate

  def initialize(empty_space: Piece.new)
    @board = new_board
    @empty_space = empty_space
    place_pieces
    @attacker_path = []
    @checkmate = true
    @forbidden = nil
  end

  def draw_board
    <<-BOARD
                    A   B   C   D   E   F   G   H#{' '}
		8 | #{@board[7][0].sign} | #{@board[7][1].sign} | #{@board[7][2].sign} | #{@board[7][3].sign} | #{@board[7][4].sign} | #{@board[7][5].sign} | #{@board[7][6].sign} | #{@board[7][7].sign} | 8
		  ---------------------------------
		7 | #{@board[6][0].sign} | #{@board[6][1].sign} | #{@board[6][2].sign} | #{@board[6][3].sign} | #{@board[6][4].sign} | #{@board[6][5].sign} | #{@board[6][6].sign} | #{@board[6][7].sign} | 7
		  ---------------------------------
		6 | #{@board[5][0].sign} | #{@board[5][1].sign} | #{@board[5][2].sign} | #{@board[5][3].sign} | #{@board[5][4].sign} | #{@board[5][5].sign} | #{@board[5][6].sign} | #{@board[5][7].sign} | 6
		  ---------------------------------
		5 | #{@board[4][0].sign} | #{@board[4][1].sign} | #{@board[4][2].sign} | #{@board[4][3].sign} | #{@board[4][4].sign} | #{@board[4][5].sign} | #{@board[4][6].sign} | #{@board[4][7].sign} | 5
		  ---------------------------------
		4 | #{@board[3][0].sign} | #{@board[3][1].sign} | #{@board[3][2].sign} | #{@board[3][3].sign} | #{@board[3][4].sign} | #{@board[3][5].sign} | #{@board[3][6].sign} | #{@board[3][7].sign} | 4
		  ---------------------------------
		3 | #{@board[2][0].sign} | #{@board[2][1].sign} | #{@board[2][2].sign} | #{@board[2][3].sign} | #{@board[2][4].sign} | #{@board[2][5].sign} | #{@board[2][6].sign} | #{@board[2][7].sign} | 3
		  ---------------------------------
		2 | #{@board[1][0].sign} | #{@board[1][1].sign} | #{@board[1][2].sign} | #{@board[1][3].sign} | #{@board[1][4].sign} | #{@board[1][5].sign} | #{@board[1][6].sign} | #{@board[1][7].sign} | 2
		  ---------------------------------
		1 | #{@board[0][0].sign} | #{@board[0][1].sign} | #{@board[0][2].sign} | #{@board[0][3].sign} | #{@board[0][4].sign} | #{@board[0][5].sign} | #{@board[0][6].sign} | #{@board[0][7].sign} | 1
                    A   B   C   D   E   F   G   H#{' '}
    BOARD
  end

  def move_piece(player, piece: player.piece, space: player.space)
    start_piece = @board[piece[0]][piece[1]]
    start_piece.update_position(space[0], space[1])
    assign_new_space(space, piece)
    assign_empty_space(piece)
    check?(start_piece)
  end

  def assign_new_space(end_space, start_space)
    @board[end_space[0]][end_space[1]] = @board[start_space[0]][start_space[1]]
  end

  def assign_empty_space(start_space)
    @board[start_space[0]][start_space[1]] = @empty_space
  end

  # def king_color(piece)
  #   if piece.color == 'white'
  #     @black_king
  #   else
  #     @white_king
  #   end
  # end

  def on_board?(row, col)
    @forbidden = true unless row.between?(0, 7) && col.between?(0, 7)
  end

  def forbidden?(from, to, piece)
    start_row = from[0]
    start_column = from[1]
    end_row = to[0]
    end_column = to[1]

    on_board?(end_row, end_column)
    path_empty?(from, to) if piece.type != :knight
    @forbidden = true if piece.illegal?(@board, start_row, start_column, end_row, end_column) == true

    return true if @forbidden == true

    @forbidden = false
    false
  end

  def path_empty?(from, to)
    row = from[0]
    col = from[1]

    if to[0] > from[0] && to[1] == from[1]
      down(row, col, to)
    elsif to[0] < from[0] && to[1] == from[1]
      up(row, col, to)
    elsif to[1] > from[1] && to[0] == from[0]
      right(row, col, to)
    elsif to[1] < from[1] && to[0] == from[0]
      left(row, col, to)
    elsif to[0] > from[0] && to[1] > from[1]
      down_right(row, col, to)
    elsif to[0] > from[0] && to[1] < from[1]
      down_left(row, col, to)
    elsif to[0] < from[0] && to[1] > from[1]
      up_right(row, col, to)
    elsif to[0] < from[0] && to[1] < from[1]
      up_left(row, col, to)
    end
  end

  def up(row, col, to)
    (row - 1).downto(to[0] + 1) do |i|
      arr = [] << [i, col]
      @attacker_path = arr
      @forbidden = true if @board[i][col].sign != ' '
      return false if @board[i][col].sign != ' '
    end
    true
  end

  def down(row, col, to)
    (row + 1).upto(to[0] - 1) do |i|
      arr = [] << [i, col]
      @attacker_path = arr
      @forbidden = true if @board[i][col].sign != ' '
      return false if @board[i][col].sign != ' '
    end
    true
  end

  def left(row, col, to)
    (col - 1).downto(to[1] + 1) do |j|
      arr = [] << [row, j]
      @attacker_path = arr
      @forbidden = true if @board[row][j].sign != ' '
      return false if @board[row][j].sign != ' '
    end
    true
  end

  def right(row, col, to)
    (col + 1).upto(to[1] - 1) do |j|
      arr = [] << [row, j]
      @attacker_path = arr
      @forbidden = true if @board[row][j].sign != ' '
      return false if @board[row][j].sign != ' '
    end
    true
  end

  def up_left(row, col, to)
    i = row - 1
    j = col - 1
    while i < to[0] - 1 && j < to[1] - 1
      arr = [] << [i, j]
      @attacker_path = arr
      @forbidden = true if @board[i][j].sign != ' '
      return false if @board[i][j].sign != ' '

      i -= 1
      j -= 1
    end
    true
  end

  def up_right(row, col, to)
    i = row - 1
    j = col + 1
    while i < to[0] - 1 && j > to[1] + 1
      arr = [] << [i, j]
      @attacker_path = arr
      @forbidden = true if @board[i][j].sign != ' '
      return false if @board[i][j].sign != ' '

      i -= 1
      j += 1
    end
    true
  end

  def down_left(row, col, to)
    i = row + 1
    j = col - 1
    while i < to[0] - 1 && j > to[1] + 1
      arr = [] << [i, j]
      @attacker_path = arr
      @forbidden = true if @board[i][j].sign != ' '
      return false if @board[i][j].sign != ' '

      i += 1
      j -= 1
    end
    true
  end

  def down_right(row, col, to)
    i = row + 1
    j = col + 1
    while i < to[0] - 1 && j < to[1] - 1
      arr = [] << [i, j]
      @attacker_path = arr
      @forbidden = true if @board[i][j].sign != ' '
      return false if @board[i][j].sign != ' '

      i += 1
      j += 1
    end
    true
  end
end
