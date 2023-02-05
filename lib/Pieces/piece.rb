# frozen_string_literal: true

# contains methods that work for all chess pieces
# individual piece classes contain move specific methods
class Piece
  attr_reader :alive, :dead, :sign, :position, :color, :moves

  def initialize(sign: ' ', position: [nil])
    @sign = sign
    @position = position
    @color = nil
  end

  def captured
    @captured = true
  end

	#default for empty space
	def illegal?(...)
		true
	end

  # tracks the current position of the piece
  def update_position(row, col)
    @position = [row, col]
  end

end
