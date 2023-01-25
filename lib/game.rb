require_relative 'save_game'

class Game
	include Save_Game

  attr_reader :game_board, :white, :black, :gameover, :current_player

  def initialize(game_board = Board.new(ChessBoard.new.piece), player1 = Player.new('White'), player2 = Player.new('Black'))
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
		if choice == 'save'
			save_game
			get_input
		elsif choice == 'quit'
			exit
		else 
			choice
		end
	end
	
	def get_input
		puts "#{@current_player.name}, select a piece to move; enter column then row. eg: 'b1'"
		puts "Or enter 'save' or 'quit'"
		save_or_quit(@current_player.select_piece)
		@current_player.translate_piece_selection
		save_or_quit(@current_player.select_space)
		@current_player.translate_space_selection		
	end

	def turn
		get_input
    @game_board.move_piece(@current_player)
		puts @game_board.draw_board

    return unless @game_over == true

    @winner = @current_player.name
  end

  def play_game(game_board = @game_board)
    puts @game_board.draw_board
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
