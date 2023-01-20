class WhiteRook < Piece
	attr_reader :sign

	def initialize(sign = '♖')
		@sign = sign
		@moves
	end
end

