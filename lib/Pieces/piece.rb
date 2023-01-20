class Piece
	attr_reader :alive, :dead, :sign 

	def initialize(sign = ' ')
		@sign = sign
		@moves
	end

	def alive
		@alive = true
	end

	def dead 
		@alive = false
	end

	def forbidden?(from, to, board)
		start_row = from[0]
		start_column = from[1]
	  end_row = to[0]
	  end_column = to[1]
		self.conditions(board, start_row, start_column, end_row, end_column)
	end

end
