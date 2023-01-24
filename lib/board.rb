class Board
  attr_accessor :board

  def initialize(board, empty_space = Piece.new)
    @board = board
    @empty_space = empty_space
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

	# def select_start(player)
	# 	player.select_piece
	# end

	# def select_end(player)
	# 	player.select_space
	# end
	
	def move_piece(player)
		start_space = player.input[0]
	  end_space = player.input[1]
		start_piece = @board[start_space[0]][start_space[1]]
		verify_input(player, start_piece, end_space, start_space)
		assign_new_space(end_space, start_space)
		assign_empty_space(start_space)
	end
	
	# def start_space(player)
		
	# end

	# def end_space(player)
		
	# end

	def verify_input(player, start_piece, end_space, start_space)
		until start_piece.forbidden?(start_space, end_space, board) == false
			##move this to another class? player?
			puts "Illegal move, choose space again or type 'cancel' to choose another piece"
			turn(player) if gets.chomp == 'cancel'
		end
	end

  def assign_new_space(end_space, start_space)
    @board[end_space[0]][end_space[1]] = @board[start_space[0]][start_space[1]]
  end

  def assign_empty_space(start_space)
    @board[start_space[0]][start_space[1]] = @empty_space
  end

end
