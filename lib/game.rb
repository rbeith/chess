require_relative 'save_game'

class Game
	include Save_Game

  attr_reader :game_board, :white, :black, :gameover

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

	def request_save
		puts "\nTo save your current game enter 'save'"
		save_game if gets.chomp == 'save'
	end

	def turn(player)
    @game_board.move_piece(player)
		puts @game_board.draw_board
		request_save
    #only need to input once? for check save.. exit.. at each step...

    return unless @game_over == true

    @winner = player.name
  end

  def turn(player)
    @game_board.move_piece(player)
		puts @game_board.draw_board
		request_save
    # check_if_win

    return unless @game_over == true

    @winner = player.name
  end

  def play_game(game_board = @game_board)
    puts @game_board.draw_board
    until @game_over == true
      turn(@player1)

      break if @game_over == true

      turn(@player2)
    end
    declare_winner
  end
end
