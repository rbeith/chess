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
		true if board[to[0]][to[1]].sign != ' '
	end
		
	
end