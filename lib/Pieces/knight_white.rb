# frozen_string_literal: true

require_relative 'knight_moves'

class WhiteKnight < Piece
  include KnightMoves

  def initialize(sign: '♘', position: [nil])
    @sign = sign
    @moves = [[2, 2, 1, -1, -2, -2, -1, 1], [1, -1, -2, -2, -1, 1, 2, 2]]
    @color = 'white'
    @position = position
  end
end
