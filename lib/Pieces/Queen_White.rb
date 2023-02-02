require_relative 'queen_moves'

class WhiteQueen < Piece
  include Queenmoves

  def initialize(sign: '♕', position: [nil])
    @sign = sign
		@color = 'white'
		@position = position
  end
end
