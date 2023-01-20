module Kingmoves 

	def forbidden?(from, to, board)
		p case
		when board[to[0]][to[1]].sign != ' '
			true
		when [to[0], to[1]] == [from[0]+1, from[1]]
			false
		when [to[0], to[1]] == [from[0]-1, from[1]]
			false
		when [to[0], to[1]] == [from[0], from[1]+1]
			false
		when [to[0], to[1]] == [from[0], from[1]-1]
			false
		when [to[0], to[1]] == [from[0]+1, from[1]-1]
			false
		when [to[0], to[1]] == [from[0]-1, from[1]+1]
			false
		when [to[0], to[1]] == [from[0]+1, from[1]+1]
			false
		when [to[0], to[1]] == [from[0]-1, from[1]-1]
			false
		else
			true
			#king cannot move into check
			#if king in check, must try to get out of check
		end
	end
end