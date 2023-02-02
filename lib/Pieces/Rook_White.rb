require_relative 'Rook_moves'

class WhiteRook < Piece
  include Rookmoves

  def initialize(sign: '♖', position: [nil])
    @sign = sign
		@color = 'black'
		@position = position
  end
end
