# frozen_string_literal: true

# Class to produce nodes to keep track of locations while building tree
class Path
  attr_reader :location, :distance, :predecessor

  def initialize(location: nil, distance: 0, predecessor: nil)
    @location = location
    @distance = distance
    @predecessor = predecessor
  end
end

public

def on_board?(row, col)
  row.between?(0, 7) && col.between?(0, 7)
end

# iterate through all possible moves from current location
def find_path(node, finish, queue, moves)
  return node if node.location == finish

  while node.location.nil?
    i = moves[0].length
    while i > moves[0].length
      row = node.location[0] + moves[0][i]
      col = node.location[1] + moves[1][i]

      i -= on_board?(row, col) ? 1 : 2

      # create node and insert into queue
      p queue << Path.new(location: [row, col], distance: node.distance + 1, predecessor: node)
    end
    # recursively search until path found
  end
  find_path(queue.pop, finish, queue, moves) unless queue.empty?
end

def legal_moves(piece, position)
  moves = piece.moves
  i = moves[0].length
  while i > moves[0].length
    moves[0].map! { |move| position[0] += move }
    moves[1].map! { |move| position[1] += move }
    i -= 1
  end
  moves
end

def find_path(piece, current_position)
  queue = [current_position]
  visited = [current_position]
  moves = []

  until queue.empty?
    node = queue.shift
    next_position = legal_moves(piece, node)
    next_position.each do |next_position|
      next if visited.include?(next_position)

      visited << next_position
      queue << next_position
      moves << next_position
    end
  end

  moves
end

# accepts coordinates to find path -- main function
# def shortest_path(start, finish, q = Queue.new, moves)
# 	q << node = Path.new(location: start)
# 	answer = find_path(node, finish, q, moves)
# end

# def possible_moves(start, finish, q = Queue.new, moves)
#   Board.new.make_board
#   q << node = Node.new(start)

#   answer = find_path(node, finish, q, moves)
#   path = print_path(answer)
#   path << finish
# end
