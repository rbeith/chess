require_relative 'Rook_moves'

class WhiteRook < Piece
  include Rookmoves

  attr_reader :sign

  def initialize(sign = '♖')
    @sign = sign
    @moves
  end
end
