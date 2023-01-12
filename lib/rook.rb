class Rook < Piece
	attr_reader :sign

	def initialize(sign)
		@sign = sign
		@moves
	end
end

