require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'ChessBoard'
Dir['./lib/Pieces/*'].each { |file| require file }

# game = Game.new
# game.play_game