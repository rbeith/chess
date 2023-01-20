class WhiteKnight < Piece
  attr_reader :sign, :moves

  def initialize(sign = '♘')
    @sign = sign
    @moves = [[2, 2, 1, -1, -2, -2, -1, 1], [1, -1, -2, -2, -1, 1, 2, 2]]
  end
end
