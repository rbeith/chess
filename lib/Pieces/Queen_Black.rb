require_relative 'Queen_moves'

class BlackQueen < Piece
  include Queenmoves

  attr_reader :sign

  def initialize(sign = '♛')
    @sign = sign
    @moves
  end
end
