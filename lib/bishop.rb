require './lib/piece.rb'

class Bishop < Piece
	
  attr_reader :sign, :moves

	def initialize(sign)
		@sign = sign
		@moves 
	end
end
	