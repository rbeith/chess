# Dir['/home/magnus/odinproject/ruby/ruby_projects/chess/lib/*'].each { |file| require file }

class Game
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

	def turn(player)
    @game_board.move_piece(player)
    #check_if_win

    return unless @game_over == true

    @winner = player.name
  end

	def play_game
    puts @game_board.draw_board
    until @game_over == true
      turn(@player1)
      puts @game_board.draw_board

      break if @game_over == true

      turn(@player2)
      puts @game_board.draw_board
    end
    declare_winner
  end
end



