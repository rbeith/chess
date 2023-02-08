# frozen_string_literal: true

require_relative 'rook_moves'

# Black Rook gamepiece class
class BlackRook < Piece
  include Rookmoves

  def initialize(sign: '♜', position: [nil])
    super
    @sign = sign
    @color = 'black'
    @position = position
  end
end
