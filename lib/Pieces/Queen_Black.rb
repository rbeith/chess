require_relative 'queen_moves'

class BlackQueen < Piece
  include Queenmoves

  def initialize(sign: '♛', position: [nil])
    @sign = sign
		@color = 'black'
		@position = position
  end
end
