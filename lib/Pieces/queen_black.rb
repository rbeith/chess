# frozen_string_literal: true

require_relative 'queen_moves'

# Black Queen gamepiece class
class BlackQueen < Piece
  include Queenmoves

  def initialize(sign: ' ♛ ', position: [nil])
    super
    @sign = sign
    @color = 'black'
    @position = position
  end
end
