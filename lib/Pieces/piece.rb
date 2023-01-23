class Piece
  attr_reader :alive, :dead, :sign

  def initialize(sign = ' ')
    @sign = sign
    @moves
  end

  def captured
    @captured = true
  end

	def check?
		#if space to is occupied by King true
		# puts "#{Player.name}, you are in check"
		# Player in check must move king out of check
		# check_mate
	end

	def check_mate
		# if no move can keep king from being captured...
		#Game.end_game
	end

  def forbidden?(from, to, board)
    start_row = from[0]
    start_column = from[1]
    end_row = to[0]
    end_column = to[1]
		check? #if check true then 
    conditions(board, start_row, start_column, end_row, end_column)
  end
end
