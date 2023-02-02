require './lib/Pieces/piece'
require_relative 'Bishop_moves'

class WhiteBishop < Piece
  include Bishopmoves

  def initialize(sign: '♗', position: [nil])
    @sign = sign
		@color = 'white'
		@position = position
  end
end
