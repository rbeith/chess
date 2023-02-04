# frozen_string_literal: true

require_relative 'board'

module ChessBoard
  attr_reader :piece,
              :white_king,
              :black_king

  def new_board
    @piece = Array.new(8) { Array.new(8, Piece.new) }
  end

  def place_pieces
    @piece[0][0] = WhiteRook.new(position: [0, 0])
    @piece[0][1] = WhiteBishop.new(position: [0, 1])
    @piece[0][2] = WhiteKnight.new(position: [0, 2])
    @piece[0][3] = WhiteQueen.new(position: [0, 3])
    @piece[0][4] = @white_king = WhiteKing.new(position: [0, 4])
    #  = @white_king
    @piece[0][5] = WhiteKnight.new(position: [0, 5])
    # @piece[0][5].update_position(0, 5)
    @piece[0][6] = WhiteBishop.new(position: [0, 6])
    @piece[0][7] = WhiteRook.new(position: [0, 7])
    @piece[1][0] = WhitePawn.new(position: [1, 0])
    @piece[1][1] = WhitePawn.new(position: [1, 1])
    @piece[1][2] = WhitePawn.new(position: [1, 2])
    @piece[1][3] = WhitePawn.new(position: [1, 3])
    @piece[1][4] = WhitePawn.new(position: [1, 4])
    @piece[1][5] = WhitePawn.new(position: [1, 5])
    @piece[1][6] = WhitePawn.new(position: [1, 6])
    @piece[1][7] = WhitePawn.new(position: [1, 7])
    @piece[6][0] = BlackPawn.new(position: [6, 0])
    @piece[6][1] = BlackPawn.new(position: [6, 1])
    @piece[6][2] = BlackPawn.new(position: [6, 2])
    @piece[6][3] = BlackPawn.new(position: [6, 3])
    @piece[6][4] = BlackPawn.new(position: [6, 4])
    @piece[6][5] = BlackPawn.new(position: [6, 5])
    @piece[6][6] = BlackPawn.new(position: [6, 6])
    @piece[6][7] = BlackPawn.new(position: [6, 7])
    @piece[7][0] = BlackRook.new(position: [7, 0])
    @piece[7][1] = BlackBishop.new(position: [7, 1])
    @piece[7][2] = BlackKnight.new(position: [7, 2])
    @piece[7][3] = BlackQueen.new(position: [7, 3])
    @piece[7][4] = @black_king = BlackKing.new(position: [7, 4])
    # @black_king
    @piece[7][5] = BlackKnight.new(position: [7, 5])
    @piece[7][6] = BlackBishop.new(position: [7, 6])
    @piece[7][7] = BlackRook.new(position: [7, 7])
  end
end
