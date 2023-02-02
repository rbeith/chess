# frozen_string_literal: true

# contains methods that work for all chess pieces
# individual piece classes contain move specific methods
class Piece
  attr_reader :alive, :dead, :sign, :position, :color, :moves

  def initialize(sign: ' ', position: [nil])
    @sign = sign
    @position = position
    @color = nil
    @moves
  end

  def captured
    @captured = true
  end

  # tracks the current position of the piece
  def update_position(row, col)
    @position = [row, col]
  end

  def check?(piece, board)
    # what about other pieces who could check after another piece moved?
    #    Ex. a Rook moves to let a queen put king in check??
    #    if king moves into check?
    # Every piece checks for check every move?
    # check if opposite king's position if forbidden?
    piece = board[piece[0]][piece[1]]
    king = if piece.color == 'white'
             board.black_king
           # need a variable? to keep track of king instances? instancevariable?
           else
             board.white_king
           end
    # need more tests -- true if false???
    board.piece.each do |row|
      row.each do |game_piece|
        p game_piece
        if game_piece.color == king.color &&
           game_piece.conditions(board, game_piece.position[0], game_piece.position[1], king.position[0],
                                 king.position[1]) == false
          # need board.piece?
          return puts "#{king.color}, Check"
        end
      end
    end
    # if any possible next move results in check_mate?
    # Player in check must move king out of check
  end

  def check_mate?(space)
    # if no move can keep king from being captured...
    puts 'Checkmate' if space.is_a?(BlackKing) || space.is_a?(WhiteKing)
    # Game.end_game
  end

  def on_board?(row, col)
    true if row.between?(0, 7) && col.between?(0, 7)
  end

  # checks if any movement is forbidden
  def forbidden?(from, to, game_board)
    start_row = from[0]
    start_column = from[1]
    end_row = to[0]
    end_column = to[1]
    return true if on_board?(end_row, end_column) == false
    return true if conditions(game_board, start_row, start_column, end_row, end_column) == true
    return true if path_empty?(from, to, direction(from, to), game_board) == false

    # return false if check?(to, game_board) == true -- somewhere else...
    false
  end

  def direction(current_position, destination)
    if destination[0] > current_position[0]
      :down
    elsif destination[0] < current_position[0]
      :up
    elsif destination[1] > current_position[1]
      :right
    elsif destination[1] < current_position[1]
      :left
    elsif destination[0] < current_position[0] && destination[1] < current_position[1]
      :up_left
    elsif destination[0] > current_position[0] && destination[1] > current_position[1]
      :up_right
    elsif destination[0] > current_position[0] && destination[1] < current_position[1]
      :down_left
    elsif destination[0] < current_position[0] && destination[1] > current_position[1]
      :down_right
    end
  end
end
