# frozen_string_literal: true

require_relative 'king_moves'

# Black King gamepiece
class BlackKing < Piece
  include Kingmoves

  def initialize(sign: ' ♚ ', position: [nil])
    super
    @sign = sign
    @position = position
    @color = 'black'
  end
end
