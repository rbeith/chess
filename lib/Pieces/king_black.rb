# frozen_string_literal: true

require_relative 'king_moves'

class BlackKing < Piece
  include Kingmoves

  def initialize(sign: '♚', position: [nil])
    @sign = sign
    @moves
    @position = [7, 4]
    @color = 'black'
  end
end
