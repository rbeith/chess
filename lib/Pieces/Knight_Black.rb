require './lib/Pieces/piece'
require_relative 'knight_moves'

class BlackKnight < Piece
  include KnightMoves

  def initialize(sign: '♞', position: [nil])
    @sign = sign
    @moves = [[2, 2, 1, -1, -2, -2, -1, 1], [1, -1, -2, -2, -1, 1, 2, 2]]
		@color = 'black'
		@position = position
  end
end
