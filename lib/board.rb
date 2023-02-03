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
	
	def move_piece(player, piece = player.piece, space = player.space)
		start_piece = @board[piece[0]][piece[1]]
		verify_input(player, start_piece, space, piece)
		start_piece.update_position(space[0], space[1])
		assign_new_space(space, piece)
		assign_empty_space(piece)
	end

	def verify_input(player, start_piece, end_space, start_space)
		until start_piece.forbidden?(start_space, end_space, self) == false
			##move this to another class? player?
			puts "Illegal move, choose space again or type 'cancel' to choose another piece"
			input = gets.chomp
			move_piece(player) if input == 'cancel'
		end
		check?(start_piece)
	end

	def assign_new_space(end_space, start_space)
		@board[end_space[0]][end_space[1]] = @board[start_space[0]][start_space[1]]
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
			if game_piece.color == king.color &&
			   game_piece.conditions(@board, game_piece.position[0], game_piece.position[1], king.position[0],
									 king.position[1]) == false
			  puts "#{king.color.upcase}, Check"
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
	puts 'Checkmate' if space.is_a?(BlackKing) || space.is_a?(WhiteKing)
	# Game.end_game
	end
end
