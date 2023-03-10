# frozen_string_literal: true

require_relative 'chess_board'
require_relative 'check'
require_relative 'pathfinder'
require 'colorize'

# class for game board and movement behavior that is not piece specific
# keeps track of piece location
class Board
  include Pathfinder
  include Check
  include ChessBoard

  attr_accessor :board, :attacker_path
  attr_reader :white_king, :black_king, :piece, :checkmate, :current_player

  def initialize(empty_space: Piece.new)
    @board = new_board
    @empty_space = empty_space
    place_pieces
    @attacker_path = []
    @checkmate = true
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
    # TODO: Undo move? could quietly save a game and load it if undo.
  end

	def piece(row, col)
		@board[row][col]
	end

	def row_from(input)
		input[0]
	end

	def col_from(input)
		input[1]
	end

	def new_space(input)
		@board[row_from(end_space)][col_from(end_space)]
	end

  def assign_new_space(end_space, start_space)
		@board[row_from(end_space)][col_from(end_space)] = piece(row_from(start_space), col_from(start_space))
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

		return true if @board[end_row][end_column].color == @board[start_row][start_column].color
    return true if on_board?(end_row, end_column) == false
    return true if path_empty?(start_space, end_space) == false && piece.type != :knight
    return true if piece.illegal?(@board, start_row, start_column, end_row, end_column) == true

    false
  end
end
