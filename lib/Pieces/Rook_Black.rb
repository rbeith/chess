require_relative 'Rook_moves'

class BlackRook < Piece
  include Rookmoves

  attr_reader :sign

  def initialize(sign: '♜', position: [nil])
    @sign = sign
    @color = 'black'
		@position = position
  end
end
