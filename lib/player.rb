class Player
	def initialize(name = 'player')
		@name = name
	end

	def select_piece
		puts "#{@name}, select a piece to move."
		puts "Enter column then row. eq: 'b1.'"
		board_location(gets.chomp)
	end

	def select_space
		puts "Select the space to move your piece to"
		board_location(gets.chomp)
	end

	def letter_to_row(input)
		y_coordinate_hash = {
			:a => 0,
			:b => 1,
			:c => 2,
			:d => 3,
			:e => 4,
			:f => 5,
			:g => 6,
			:h => 7,
		}
		y_coordinate_hash[input]
	end

	def board_location(input = gets.chomp)
		arr = input.split(//)
		arr[0] = letter_to_row(arr[0].to_sym)
		arr[1] = arr[1].to_i - 1
		arr
	end
end
