require_relative 'king_moves'

class WhiteKing < Piece
  include Kingmoves

  def initialize(sign: '♔', position: [nil])
    @sign = sign
    @moves
		@position = [0, 4]
		@color = 'white'
  end

end