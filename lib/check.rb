# frozen_string_literal: true

# Methods to check for check and checkmate.
module Check
	# TODO: If king in check must move out of check or piece must block check path.
	# TODO: King can't move into check??
	# TODO: If king stays in check declare check
	# TODO: If king is taken #gameover
	def king_color(piece)
    if piece.color == 'white'
      @black_king
    else
      @white_king
    end
  end

  def can_attack?(king)
    @board.each do |row|
      row.each do |game_piece|
        # FIXME: Players own piece movement reveals their king in check?
        next unless game_piece.color != king.color && game_piece.sign != ' ' && game_piece != king

        if forbidden?([game_piece.position[0], game_piece.position[1]],
                   [king.position[0], king.position[1]],
                   game_piece) == false
        	@attacker = game_piece
          return true
				end
      end
    end
    false
  end

  def check_statement(king)
    puts "\n\n#{king.color.upcase}, YOUR KING IS IN CHECK!\n\n\n"
  end

  def check?(piece)
    king = king_color(piece)
    if can_attack?(king) == true
			check_statement(king)
			checkmate?(king)
			true
		end
  end

	def king_move_blocked?(king)
		possible_moves = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
		blocked = false
		possible_moves.each do |m|
			move = [(king.position[0] + m[0]), (king.position[1] + m[1])]
			if forbidden?(king.position, move, king) == false
				if king.color == 'white'
					king = WhiteKing.new(position: move)
				else
					king = BlackKing.new(position: move)
				end
				blocked = true if can_attack?(king) == true
			end
		end
		blocked
	end

	def checkmate?(king)
		declare_checkmate if check_blocking_pieces?(king) && king_move_blocked?(king)
	end

	def declare_checkmate
		print "Checkmate! #{@current_player.name} wins!"
	end

  # TODO: king cannot move out of attach_path
  # Game.end_game || EndGameClass.new(@current_player....)...
  def check_blocking_pieces?(king)
    @board.each do |row|
      row.each do |piece|
        next unless piece != king && piece.color == king.color

        mated = attack_path_blocked?(piece)
        return false if mated == false
      end
    end
    true
  end

  def attack_path_blocked?(piece)
    blocked = true
    i = (@attacker_path.length - 1)
    while i >= 0
      if path_empty?(piece.position, @attacker_path[i])
        blocked = false if piece.illegal?(@board, piece.position[0], piece.position[1], @attacker_path[i][0],
                                          @attacker_path[i][1])
        break if blocked == false
      end
      i -= 1
    end
    blocked
  end
end
