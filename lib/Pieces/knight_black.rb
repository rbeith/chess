# frozen_string_literal: true

require './lib/Pieces/piece'
require_relative 'knight_moves'

# Black Knight gamepiece
class BlackKnight < Piece
  include KnightMoves

  def initialize(sign: ' ♞ ', position: [nil])
    super
    @sign = sign
    @color = 'black'
    @position = position
    @type = :knight
  end
end
