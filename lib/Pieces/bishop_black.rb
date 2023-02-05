# frozen_string_literal: true

require './lib/Pieces/piece'
require_relative 'bishop_moves'

# Black Bishop gamepiece
class BlackBishop < Piece
  include Bishopmoves

  def initialize(sign: '♝', position: [nil])
    @sign = sign
    @color = 'black'
    @position = position
  end
end
