require './lib/Pieces/piece.rb'
require_relative 'Bishop_moves'

class BlackBishop < Piece
	include Bishopmoves
	
  attr_reader :sign, :moves

	def initialize(sign = '♝')
		@sign = sign
		@moves 
	end
end
	