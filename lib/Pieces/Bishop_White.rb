require './lib/Pieces/piece'
require_relative 'Bishop_moves'

class WhiteBishop < Piece
  include Bishopmoves

  attr_reader :sign, :moves

  def initialize(sign = '♗')
    @sign = sign
    @moves
  end
end
