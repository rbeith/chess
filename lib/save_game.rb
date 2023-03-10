# frozen_string_literal: true

# Methods for saving and retrieving saved games
module SaveGame
  def save_game
    puts "\n"
    puts '    * * * * * * * *'
    puts '      Game saved'
    puts '    * * * * * * * *'
    puts "\n"
    file_name = Time.new.localtime
    # need to save more files... board, etc.??
    File.open("saved_games/#{file_name}.yml", 'w') { |file| file.write(to_yaml) }
  end

  def load_game
    puts "\nTo see a list of saved games, enter \'y\'."
    puts 'Or press any key to continue.'
    input = $stdin.gets.chomp
    if input == 'y'
      choose_file
      game = YAML.safe_load_file("saved_games/#{@game_to_load}", aliases: true, permitted_classes: [Game,
                                                                                                    Board,
                                                                                                    Player,
                                                                                                    Piece,
                                                                                                    WhiteRook,
                                                                                                    WhiteBishop,
                                                                                                    WhiteKnight,
                                                                                                    WhiteKing,
                                                                                                    WhiteQueen,
                                                                                                    WhitePawn,
                                                                                                    BlackPawn,
                                                                                                    BlackQueen,
                                                                                                    BlackKing,
                                                                                                    BlackBishop,
                                                                                                    BlackKnight,
                                                                                                    BlackRook])
      game.play_game
    else
      play_game
    end
  end

  def empty_directory
    return unless Dir.empty?('saved_games')

    puts "\n\n\n\nNo saved games... Try again.\n\n\n\n"
    load_game
  end

  def list_saved_games(directory)
    directory.each_child { |file| saved_games.push(file) }
    puts "\nHere is a list of saved games:"
    saved_games.each_with_index { |file, index| puts "\n#{index + 1}: #{file}" }
    puts 'Enter the number to open the saved game.'
  end

  def choose_file
    saved_games = []
    game_dir = Dir.open('saved_games')
    empty_directory
    list_saved_games(game_dir)
    @game_to_load = saved_games[gets.chomp.to_i - 1]
  end
end
