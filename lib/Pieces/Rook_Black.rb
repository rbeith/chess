require_relative 'Rook_moves'

class BlackRook < Piece
	include Rookmoves
	
	attr_reader :sign

	def initialize(sign = '♜')
		@sign = sign
		@moves
	end
end

