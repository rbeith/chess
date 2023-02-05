# frozen_string_literal: true

require_relative 'knight_moves'

# White Knight gamepiece
class WhiteKnight < Piece
  include KnightMoves

  def initialize(sign: '♘', position: [nil])
    @sign = sign
    @color = 'white'
    @position = position
		@type = :knight
  end
end
