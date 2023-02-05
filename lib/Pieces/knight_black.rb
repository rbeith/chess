# frozen_string_literal: true

require './lib/Pieces/piece'
require_relative 'knight_moves'

class BlackKnight < Piece
  include KnightMoves

  def initialize(sign: '♞', position: [nil])
    @sign = sign
    @color = 'black'
    @position = position
  end
end
