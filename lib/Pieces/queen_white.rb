# frozen_string_literal: true

require_relative 'queen_moves'

# White Queen gamepiece class
class WhiteQueen < Piece
  include Queenmoves

  def initialize(sign: '♕', position: [nil])
    super
    @sign = sign
    @color = 'white'
    @position = position
  end
end
