# frozen_string_literal: true

require_relative 'chess_board'

class Board
  include ChessBoard

  attr_accessor :board
  attr_reader :white_king, :black_king, :piece

  def initialize(empty_space: Piece.new)
    @board = new_board
    @empty_space = empty_space
    place_pieces
  end

  def draw_board
    <<-BOARD
                    1   2   3   4   5   6   7   8#{' '}
		a | #{@board[0][0].sign} | #{@board[0][1].sign} | #{@board[0][2].sign} | #{@board[0][3].sign} | #{@board[0][4].sign} | #{@board[0][5].sign} | #{@board[0][6].sign} | #{@board[0][7].sign} |
		  ---------------------------------
		b | #{@board[1][0].sign} | #{@board[1][1].sign} | #{@board[1][2].sign} | #{@board[1][3].sign} | #{@board[1][4].sign} | #{@board[1][5].sign} | #{@board[1][6].sign} | #{@board[1][7].sign} |
		  ---------------------------------
		c | #{@board[2][0].sign} | #{@board[2][1].sign} | #{@board[2][2].sign} | #{@board[2][3].sign} | #{@board[2][4].sign} | #{@board[2][5].sign} | #{@board[2][6].sign} | #{@board[2][7].sign} |
		  ---------------------------------
		d | #{@board[3][0].sign} | #{@board[3][1].sign} | #{@board[3][2].sign} | #{@board[3][3].sign} | #{@board[3][4].sign} | #{@board[3][5].sign} | #{@board[3][6].sign} | #{@board[3][7].sign} |
		  ---------------------------------
		e | #{@board[4][0].sign} | #{@board[4][1].sign} | #{@board[4][2].sign} | #{@board[4][3].sign} | #{@board[4][4].sign} | #{@board[4][5].sign} | #{@board[4][6].sign} | #{@board[4][7].sign} |
		  ---------------------------------
		f | #{@board[5][0].sign} | #{@board[5][1].sign} | #{@board[5][2].sign} | #{@board[5][3].sign} | #{@board[5][4].sign} | #{@board[5][5].sign} | #{@board[5][6].sign} | #{@board[5][7].sign} |
		  ---------------------------------
		g | #{@board[6][0].sign} | #{@board[6][1].sign} | #{@board[6][2].sign} | #{@board[6][3].sign} | #{@board[6][4].sign} | #{@board[6][5].sign} | #{@board[6][6].sign} | #{@board[6][7].sign} |
		  ---------------------------------
		h | #{@board[7][0].sign} | #{@board[7][1].sign} | #{@board[7][2].sign} | #{@board[7][3].sign} | #{@board[7][4].sign} | #{@board[7][5].sign} | #{@board[7][6].sign} | #{@board[7][7].sign} |
		  ---------------------------------
    BOARD
  end

  def move_piece(player, piece: player.piece, space: player.space)
    start_piece = @board[piece[0]][piece[1]]
    # verify_input(player, start_piece, space, piece)
    start_piece.update_position(space[0], space[1])
    assign_new_space(space, piece)
    assign_empty_space(piece)
		check?(start_piece) ##move to game??????
  end

  # def verify_input(player, start_piece, end_space, start_space)
  #   until forbidden?(start_space, end_space, start_piece) == false
  #     puts "Illegal move, choose space again or type 'cancel' to choose another piece"
  #     input = gets.chomp
  #     if input == 'cancel'
	# 			move_piece(player, piece: player.select_piece, space: player.select_space)
	# 		else
	# 			move_piece(player, space: input)
	# 		end
  #   end
  # end

  def assign_new_space(end_space, start_space)
    p @board[end_space[0]][end_space[1]] = @board[start_space[0]][start_space[1]]
  end

  def assign_empty_space(start_space)
    @board[start_space[0]][start_space[1]] = @empty_space
  end

  def check?(piece)
    # what about other pieces who could check after another piece moved?
    #    Ex. a Rook moves to let a queen put king in check??
    #    if king moves into check?
    # Every piece checks for check every move?
    # check if opposite king's position if forbidden?
    king = if piece.color == 'white'
             @black_king
           else
             @white_king
           end
    @board.each do |row|
      row.each do |game_piece|
        if (game_piece.color != king.color &&
               forbidden?([game_piece.position[0], game_piece.position[1]], [king.position[0],
                                     king.position[1]], game_piece) == false)
																		 p game_piece
					puts "\n\n#{king.color.upcase}, CHECK\n\n\n"
        	return true
				end
      end
      false
    end
    # if any possible next move results in check_mate?
    # Player in check must move king out of check
  end

  def check_mate?(space)
    # if no move can keep king from being captured...
		# and king cannot move to a safe space.
    puts 'Checkmate' if space.is_a?(BlackKing) || space.is_a?(WhiteKing)
    # Game.end_game
  end

	def on_board?(row, col)
    true if row.between?(0, 7) && col.between?(0, 7)
  end

  # checks if any movement is forbidden
  def forbidden?(from, to, piece)
    start_row = from[0]
    start_column = from[1]
    end_row = to[0]
    end_column = to[1]
    return true if on_board?(end_row, end_column) == false
    return true if piece.conditions(@board, start_row, start_column, end_row, end_column) == true
    return true if path_empty?(from, to) == false

    false
  end

  def path_empty?(from, to)
		direction = direction(from, to)
    row = from[0]
    col = from[1]
    case direction
    when :up
			(row - 1).downto(to[0]) do |i|
        return false if @board[i][col].sign != ' '
      end
    when :down
      (row + 1).upto(to[0]) do |i|
        return false if @board[i][col].sign != ' '
      end
    when :left
      (col - 1).downto(to[1]) do |j|
        return false if @board[row][j].sign != ' '
      end
    when :right
      (col + 1).upto(to[1]) do |j|
        return false if @board[row][j].sign != ' '
      end
    when :up_left
      i = row - 1
      j = col - 1
      while i <= to[0] && j <= to[1]
        return false if @board[i][j].sign != ' '

        i -= 1
        j -= 1
      end
    when :up_right
      i = row - 1
      j = col + 1
      while i <= to[0] && j >= to[1]
        return false if @board[i][j].sign != ' '

        i -= 1
        j += 1
      end
    when :down_left
      i = row + 1
      j = col - 1
      while i < to[0] && j >= to[1]
        return false if @board[i][j].sign != ' '

        i += 1
        j -= 1
      end
    when :down_right
      i = row + 1
      j = col + 1
      while i < to[0] && j < to[1]
        return false if @board[i][j].sign != ' '

        i += 1
        j += 1
      end
    end
    true
  end

  def direction(from, to)
    if to[0] > from[0] && to[1] == from[1]
      :down
    elsif to[0] < from[0] && to[1] == from[1]
      :up
    elsif to[1] > from[1] && to[0] == from[0]
      :right
    elsif to[1] < from[1] && to[0] == from[0]
      :left
    elsif to[0] > from[0] && to[1] > from[1]
      :down_right
    elsif to[0] > from[0] && to[1] < from[1]
      :down_left
    elsif to[0] < from[0] && to[1] > from[1]
      :up_right
    elsif to[0] < from[0] && to[1] < from[1]
      :up_left
    end
  end
end
