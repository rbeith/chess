# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'chess_board'
require 'yaml'
Dir['./lib/Pieces/*'].sort.each { |file| require file }

Game.new.load_game
