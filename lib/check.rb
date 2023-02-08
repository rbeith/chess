# frozen_string_literal: true

# Methods to check for check and checkmate.
module Check
	def king_color(piece)
    if piece.color == 'white'
      @black_king
    else
      @white_king
    end
  end
	
  def check_each_piece(king)
    @board.each do |row|
      row.each do |game_piece|
        # FIXME: Players own piece movement reveals their king in check?
        next unless game_piece.color != king.color && game_piece.sign != ' ' && game_piece != king

        if forbidden?([game_piece.position[0], game_piece.position[1]],
                   [king.position[0], king.position[1]],
                   game_piece) == false
        	@attacker = game_piece
        	checkmate?(king)
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
    check_statement(king) if check_each_piece(king) == true
    check_each_piece(king)
  end

  
  # TODO: king cannot move out of attach_path
  # Game.end_game || EndGameClass.new(@currentplayer....)...
  def checkmate?(king)
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
