# frozen_string_literal: true

require './lib/Pieces/piece'
require_relative 'bishop_moves'

# White Bishop gamepiece
class WhiteBishop < Piece
  include Bishopmoves

  def initialize(sign: '♗', position: [nil])
    @sign = sign
    @color = 'white'
    @position = position
  end
end
