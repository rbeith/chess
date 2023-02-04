# frozen_string_literal: true

class Player
  attr_reader :name, :input, :space, :piece

  def initialize(name: 'player')
    @name = name
  end

  def input(_space, _piece)
    @input = @space + @piece
  end

  def piece_row
    @piece_row = @piece[0]
  end

  def piece_column
    @piece_column = @piece[1]
  end

  def space_row
    @space_row = @space[0]
  end

  def space_column
    @space_column = @space[1]
  end

  def select_piece
    @piece = gets.chomp
  end

  def translate_piece_selection
    @piece = board_location(piece)
  end

  def select_space
    puts 'Select the space to move your piece to'
    @space = gets.chomp
  end

  def translate_space_selection
    @space = board_location(space)
  end

  def letter_to_row(input)
    y_coordinate_hash = {
      a: 0,
      b: 1,
      c: 2,
      d: 3,
      e: 4,
      f: 5,
      g: 6,
      h: 7
    }
    y_coordinate_hash[input]
  end

  def board_location(input = gets.chomp)
    arr = input.split(//)
    arr[0] = letter_to_row(arr[0].to_sym)
    arr[1] = arr[1].to_i - 1
    arr
  end
end
