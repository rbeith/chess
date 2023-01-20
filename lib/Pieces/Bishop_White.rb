require './lib/Pieces/piece.rb'
require_relative 'Bishopmoves'

class WhiteBishop < Piece
	include Bishopmoves
	
  attr_reader :sign, :moves

	def initialize(sign = '♗')
		@sign = sign
		@moves 
	end

end
	