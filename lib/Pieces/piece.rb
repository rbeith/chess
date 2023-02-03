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
    # return true if check?(game_board[from[0]][to[0]], game_board) == true
    false
  end

  def path_empty?(position, destination, direction, board)
    row = position[0]
    col = position[1]
    case direction
    when :up
      (row - 1..destination[0]).each do |i|
        return false if board[i][col].sign != ' '
      end
    when :down
      (row + 1..destination[0]).each do |i|
        return false if board[i][col].sign != ' '
      end
    when :left
      (col - 1..destination[1]).each do |j|
        return false if board[row][j].sign != ' '
      end
    when :right
      (col + 1..destination[1]).each do |j|
        return false if board[row][j].sign != ' '
      end
    when :up_left
      i = row - 1
      j = col - 1
      while i <= destination[0] && j <= destination[1]
        return false if board[i][j].sign != ' '
  
        i -= 1
        j -= 1
      end
    when :up_right
      i = row - 1
      j = col + 1
      while i <= destination[0] && j >= destination[1]
        return false if board[i][j].sign != ' '
  
        i -= 1
        j += 1
      end
    when :down_left
      i = row + 1
      j = col - 1
      while i < destination[0] && j >= destination[1]
        return false if board[i][j].sign != ' '
  
        i += 1
        j -= 1
      end
    when :down_right
      i = row + 1
      j = col + 1
      while i < destination[0] && j < destination[1]
        return false if board[i][j].sign != ' '
  
        i += 1
        j += 1
      end
    end
    true
  end

  def direction(current_position, destination)
    if destination[0] > current_position[0] && destination[1] == current_position[1]
      :down
    elsif destination[0] < current_position[0] && destination[1] == current_position[1]
      :up
    elsif destination[1] > current_position[1] && destination[0] == current_position[0]
      :right
    elsif destination[1] < current_position[1] && destination[0] == current_position[0]
      :left
    elsif destination[0] > current_position[0] && destination[1] > current_position[1]
      :down_right
    elsif destination[0] > current_position[0] && destination[1] < current_position[1]
      :up_right
    elsif destination[0] < current_position[0] && destination[1] > current_position[1]
      :down_left
    elsif destination[0] < current_position[0] && destination[1] < current_position[1]
      :up_left
    end
  end
end
