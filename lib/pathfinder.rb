# frozen_string_literal: true

# Finds the path from a piece in the given direction
module Pathfinder
  def path_empty?(from, to)
    row = from[0]
    col = from[1]

    if to[0] > from[0] && to[1] == from[1]
      down(row, col, to)
    elsif to[0] < from[0] && to[1] == from[1]
      up(row, col, to)
    elsif to[1] > from[1] && to[0] == from[0]
      right(row, col, to)
    elsif to[1] < from[1] && to[0] == from[0]
      left(row, col, to)
    elsif to[0] > from[0] && to[1] > from[1]
      down_right(row, col, to)
    elsif to[0] > from[0] && to[1] < from[1]
      down_left(row, col, to)
    elsif to[0] < from[0] && to[1] > from[1]
      up_right(row, col, to)
    elsif to[0] < from[0] && to[1] < from[1]
      up_left(row, col, to)
    end
  end

  def empty_space?(row, col)
    true if sign(locate_piece(row, col)) != '   '
  end

  def up(row, col, to)
    (row - 1).downto(to[0] + 1) do |i|
      arr = [] << [i, col]
      @attacker_path = arr
      return false if empty_space?(i, col)
    end
    true
  end

  def down(row, col, to)
    (row + 1).upto(to[0] - 1) do |i|
      arr = [] << [i, col]
      @attacker_path = arr
      return false if empty_space?(i, col)
    end
    true
  end

  def left(row, col, to)
    (col - 1).downto(to[1] + 1) do |j|
      arr = [] << [row, j]
      @attacker_path = arr
      return false if empty_space?(row, j)
    end
    true
  end

  def right(row, col, to)
    (col + 1).upto(to[1] - 1) do |j|
      arr = [] << [row, j]
      @attacker_path = arr
      return false if empty_space?(row, j)
    end
    true
  end

  def up_left(row, col, to)
    i = row - 1
    j = col - 1
    while i < to[0] - 1 && j < to[1] - 1
      arr = [] << [i, j]
      @attacker_path = arr
      return false if empty_space?(i, j)

      i -= 1
      j -= 1
    end
    true
  end

  def up_right(row, col, to)
    i = row - 1
    j = col + 1
    while i < to[0] - 1 && j > to[1] + 1
      arr = [] << [i, j]
      @attacker_path = arr
      return false if empty_space?(i, j)

      i -= 1
      j += 1
    end
    true
  end

  def down_left(row, col, to)
    i = row + 1
    j = col - 1
    while i < to[0] - 1 && j > to[1] + 1
      arr = [] << [i, j]
      @attacker_path = arr
      return false if empty_space?(i, j)

      i += 1
      j -= 1
    end
    true
  end

  def down_right(row, col, to)
    i = row + 1
    j = col + 1
    while i < to[0] - 1 && j < to[1] - 1
      arr = [] << [i, j]
      @attacker_path = arr
      return false if empty_space?(i, j)

      i += 1
      j += 1
    end
    true
  end
end
