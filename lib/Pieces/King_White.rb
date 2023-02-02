require_relative 'King_moves'

class WhiteKing < Piece
  include Kingmoves

  attr_reader :sign, :position

  def initialize(sign: '♔', position: [nil])
    @sign = sign
    @moves
		@position = [0, 4]
		@color = 'white'
  end

end