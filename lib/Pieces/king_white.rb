# frozen_string_literal: true

require_relative 'king_moves'

# White King gamepiece
class WhiteKing < Piece
  include Kingmoves

  def initialize(sign: '♔', position: [nil])
    @sign = sign
    @position = position
    @color = 'white'
  end
end
