# frozen_string_literal: true

# contains methods that work for all chess pieces
# individual piece classes contain move specific methods
class Piece
  attr_reader :alive, :dead, :sign, :position, :color, :moves, :type

  def initialize(sign: '   ', position: [nil])
    @sign = sign
    @position = position
    @color = nil
  end

  def captured
    @captured = true
  end

  def illegal?(*_arguments)
    true
  end

  def update_position(row, col)
		@position = [row, col]
  end
	
end
