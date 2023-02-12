# frozen_string_literal: true

require_relative 'rook_moves'

# White Rook gamepiece class
class WhiteRook < Piece
  include Rookmoves

  def initialize(sign: ' ♖ ', position: [nil])
    super
    @sign = sign
    @color = 'white'
    @position = position
  end
end
