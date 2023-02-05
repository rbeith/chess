# frozen_string_literal: true

require_relative 'save_game'

# Methods for starting, playing, and ending a game
class Game
  include SaveGame

  attr_reader :game_board, :white, :black, :gameover, :current_player

  def initialize(game_board: Board.new,
                 player1: Player.new(name: 'White'),
                 player2: Player.new(name: 'Black'))
    @game_board = game_board
    @player1 = player1
    @player2 = player2
    @gameover = false
  end

  def end_game
    @gameover = true
  end

  def declare_winner
    puts "#{@winner} wins!"
  end

  def message
    puts "Select space. Enter column then row eg. 'b1'"
  end

  def save_or_quit(choice)
    case choice
    when 'save'
      save_game
      player_input
    when 'quit'
      exit
    else
      choice
    end
  end

  def player_input
    puts "#{@current_player.name}, select a piece to move; enter column then row. eg: 'b1'"
    puts "Or enter 'save' or 'quit'"
    save_or_quit(select_piece)
    @current_player.translate_piece_selection
    puts 'Select the space to move your piece to'
    save_or_quit(select_space)
    @current_player.translate_space_selection
    player_input if verify_input(@current_player, current_piece, selected_space, selected_piece) == false
  end

  def select_piece
    @current_player.select_piece
  end

  def select_space
    @current_player.select_space
  end

  def draw_board
    @game_board.draw_board
  end

  def current_piece
    @current_piece = @game_board.piece[@current_player.piece[0]][@current_player.piece[1]]
  end

  def reset_space(space)
    @current_player.space = space
  end

  def selected_space
    @current_player.space
  end

  def reset_piece(piece)
    @current_player.piece = piece
  end

  def selected_piece
    @current_player.piece
  end

  def verify_input(_player, start_piece, end_space, start_space)
    if @game_board.forbidden?(start_space, end_space, start_piece) == true
      puts "\n\nForbidden move, choose again.\n\n\n"
      false
    else
      true
    end
  end

  def turn
    player_input
    @game_board.move_piece(@current_player)
    puts draw_board

    return unless @game_over == true

    winner
  end

  def winner
    @winner = @current_player.name
  end

  def play_game(_game_board = @game_board)
    puts draw_board
    until @game_over == true
      @current_player = @player1
      turn

      break if @game_over == true

      @current_player = @player2
      turn
    end
    declare_winner
  end
end
