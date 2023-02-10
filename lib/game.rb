# frozen_string_literal: true

require_relative 'save_game'

# Methods for starting, playing, and ending a game
class Game
  include SaveGame

  attr_reader :game_board, :white, :black, :gameover, :current_player

  def initialize(game_board: Board.new,
                 player1: Player.new(name: 'White', color: 'white'),
                 player2: Player.new(name: 'Black', color: 'black'))
    @game_board = game_board
    @player1 = player1
    @player2 = player2
    @gameover = false
  end

  def end_game
    @gameover = true
  end

  def declare_winner
    puts "#{@current_player} wins!"
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
    @current_piece = @game_board.board[@current_player.piece[0]][@current_player.piece[1]]
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

  def player_input
    # TODO: no error for invalid input
    # TODO: Highlight or announce or display selected piece
    puts "#{@current_player.name}, select a piece to move; enter column then row. eg: 'b1'"
    puts "Or enter 'save' or 'quit'"
    save_or_quit(select_piece)
    @current_player.translate_piece_selection
    puts 'Select the space to move your piece to'
    save_or_quit(select_space)
    @current_player.translate_space_selection
    player_input if verify_input(@current_player, current_piece, selected_space, selected_piece) == false
  end

	def same_color?(player, end_piece)
		true if player.color == end_piece.color
	end

	def space_not_empty?(end_piece)
		true if end_piece.sign == ' '
	end

  def verify_input(player, start_piece, end_space, start_space)
	  end_piece = @game_board.board[end_space[0]][end_space[1]]
		verified = true
		verified = false if same_color?(player, end_piece) || space_not_empty?(end_piece) ||
    @game_board.forbidden?(start_space, end_space, start_piece)
    puts "\n\nForbidden move, choose again.\n\n\n" if verified == false
    verified
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

  def play_game
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
