# frozen_string_literal: true

# Methods to check for check and checkmate.
module Check
  # TODO: If king in check must move out of check or piece must block check path.
  # TODO: King can't move into check??
  # TODO: If king stays in check declare check
  # TODO: If king is taken #gameover
  def king_color(piece)
    if color(piece) == 'white'
      @black_king
    else
      @white_king
    end
  end

  def color(piece)
    piece.color
  end

  def position(piece)
    piece.position
  end

  def sign(piece)
    piece.sign
  end

  def row(piece)
    position(piece)[0]
  end

  def column(piece)
    position(piece)[1]
  end

  def can_attack?(king)
    @board.each do |row|
      row.each do |piece|
        # FIXME: Players own piece movement reveals their king in check?
        next unless color(piece) != color(king) && sign(piece) != '   ' && piece != king

        next unless forbidden?([row(piece), column(piece)],
                               [row(king), column(king)],
                               piece) == false

        return true
      end
    end
    false
  end

  def check_statement(king)
    puts "\n\n#{color(king).upcase}, YOUR KING IS IN CHECK!\n\n\n"
  end

  def check?(piece)
    king = king_color(piece)
    return unless can_attack?(king) == true

    check_statement(king)
    checkmate?(king)
    true
  end

  def temp_king(king, move)
    if color(king) == 'white'
      WhiteKing.new(position: move)
    else
      BlackKing.new(position: move)
    end
  end

  def king_move_blocked?(king)
    blocked = false
    king.possible_moves.each do |m|
      move = [(row(king) + m[0]), (column(king) + m[1])]
      next unless forbidden?(position(king), move, king) == false

      king = temp_king(king, move)
      blocked = true if can_attack?(king) == true
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
        next unless piece != king && color(piece) == color(king)

        mated = attack_path_blocked?(piece)
        return false if mated == false
      end
    end
    true
  end

  def blocking_piece?(piece, count)
    if path_empty?(position(piece), @attacker_path[count]) &&
       piece.illegal?(@board, row(piece), column(piece),
                      @attacker_path[count][0], @attacker_path[count][1])
      false
    end
  end

  def attack_path_blocked?(piece)
    blocked = true
    i = (@attacker_path.length - 1)
    while i >= 0
      blocked = blocking_piece?(piece, i)
      break if blocked == false

      i -= 1
    end
    blocked
  end
end
