# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'check'
require_relative 'pathfinder'
require 'colorize'

# class for game board \\and\\ movement behavior that is not piece specific
# keeps track of piece location
class Board
  include Pathfinder
  include Check
  include ChessBoard

  attr_accessor :board, :attacker_path
  attr_reader :white_king, :black_king, :checkmate, :current_player

  def initialize(empty_space: Piece.new)
    new_board
    @empty_space = empty_space
    @attacker_path = []
  end

  def draw_board
    system 'clear'
    print row_coordinates
    0.upto(7) do |row|
      print column_coordinates(row).to_s
      assemble_row(row)
      print column_coordinates(row).to_s
      print "\n"
    end
    print row_coordinates
  end

  def row_coordinates
    "    A  B  C  D  E  F  G  H    \n".colorize(background: :light_black)
  end

  def column_coordinates(row_num)
    " #{row_num + 1} ".colorize(background: :light_black)
  end

  def board_square(row, col)
    if (row + col).even?
      @board[row][col].sign.to_s.colorize(background: :light_white)
    else
      @board[row][col].sign.to_s.colorize(background: :light_blue)
    end
  end

  def assemble_row(row_num)
    0.upto(7) { |col_num| print board_square(row_num, col_num) }
  end

  def move_piece(player, starting_position: player.piece, ending_position: player.space)
    @current_player = player
    start_piece = locate_piece(starting_position[0], starting_position[1])
    start_piece.update_position(ending_position[0], ending_position[1])
    assign_new_space(ending_position, starting_position)
    assign_empty_space(starting_position)
    check?(start_piece)
    # TODO: Undo move? could quietly save a game and load it if undo.
  end

  def locate_piece(row, col)
    @board[row][col]
  end

  def row_from(input)
    input[0]
  end

  def col_from(input)
    input[1]
  end

  def new_space(_input)
    @board[row_from(end_space)][col_from(end_space)]
  end

  def assign_new_space(end_space, start_space)
    @board[row_from(end_space)][col_from(end_space)] = locate_piece(row_from(start_space), col_from(start_space))
  end

  def assign_empty_space(start_space)
    @board[start_space[0]][start_space[1]] = @empty_space
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end

  def forbidden?(start_space, end_space, piece)
    start_row = row_from(start_space)
    start_column = col_from(start_space)
    end_row = row_from(end_space)
    end_column = col_from(end_space)

    # return true if @board[end_row][end_column].color == @board[start_row][start_column].color
    return true if on_board?(end_row, end_column) == false
    return true if path_empty?(start_space, end_space) == false && piece.type != :knight
    return true if piece.illegal?(@board, start_row, start_column, end_row, end_column) == true

    false
  end
end
