require_relative 'Queen_moves'

class WhiteQueen < Piece
  include Queenmoves

  attr_reader :sign

  def initialize(sign = '♕')
    @sign = sign
    @moves
  end
end
