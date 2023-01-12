# Dir['/home/magnus/odinproject/ruby/ruby_projects/chess/lib/*'].each { |file| require file }

class Game
	attr_reader :game_board, :white, :black, :gameover

	def initialize
		@game_board = Board.new
		@white = Player.new('White')
		@black = Player.new('Black')
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
      turn(@white)
      puts @game_board.draw_board

      break if @game_over == true

      turn(@black)
      puts @game_board.draw_board
    end
    declare_winner
  end
end



