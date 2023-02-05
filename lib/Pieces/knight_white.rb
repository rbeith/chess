# frozen_string_literal: true

require_relative 'knight_moves'

class WhiteKnight < Piece
  include KnightMoves

  def initialize(sign: '♘', position: [nil])
    @sign = sign
    @color = 'white'
    @position = position
  end
end
