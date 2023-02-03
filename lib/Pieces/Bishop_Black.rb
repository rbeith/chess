require './lib/Pieces/piece'
require_relative 'bishop_moves'

class BlackBishop < Piece
  include Bishopmoves

  def initialize(sign: '♝', position: [nil])
    @sign = sign
		@color = 'black'
		@position = position
  end
end
