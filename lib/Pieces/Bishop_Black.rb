require './lib/Pieces/piece'
require_relative 'Bishop_moves'

class BlackBishop < Piece
  include Bishopmoves

  attr_reader :sign, :moves

  def initialize(sign: '♝', position: [nil])
    @sign = sign
		@color = 'black'
		@position = position
  end
end
