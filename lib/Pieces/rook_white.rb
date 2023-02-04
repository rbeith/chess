# frozen_string_literal: true

require_relative 'rook_moves'

class WhiteRook < Piece
  include Rookmoves

  def initialize(sign: '♖', position: [nil])
    @sign = sign
    @color = 'black'
    @position = position
  end
end
