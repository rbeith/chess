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
	
end