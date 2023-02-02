require_relative 'King_moves'

class BlackKing < Piece
  include Kingmoves

  attr_reader :sign

  def initialize(sign: '♚', position: [nil])
    @sign = sign
    @moves
		@position = [7, 4]
		@color = 'black'
  end
end
