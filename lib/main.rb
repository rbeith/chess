Dir['./lib/*'].each { |file| require file }

game = Game.new
game.play_game