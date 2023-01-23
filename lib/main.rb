require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'ChessBoard'
require 'yaml'
Dir['./lib/Pieces/*'].each { |file| require file }

Game.new.load_game
