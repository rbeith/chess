require_relative 'King_moves'

class BlackKing < Piece
	include Kingmoves

	attr_reader :sign

	def initialize(sign = '♚')
		@sign = sign
		@moves
	end

end