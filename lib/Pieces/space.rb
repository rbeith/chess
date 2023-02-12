# frozen_string_literal: true

#holds a space number to assist with coloring the board
class Space < Piece
	attr_accessor :piece, :number

	def initialize(piece: Piece.new, number: nil)
		@piece = piece
	  @number = number
	end

end
