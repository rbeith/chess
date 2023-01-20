# Class to produce nodes to keep track of locations while building tree
class Node
  attr_reader :location, :distance, :predecessor

  def initialize(location = nil, distance = 0, predecessor = nil)
    @location = location
    @distance = distance
    @predecessor = predecessor
  end
end

# check if move is allowed
def legal_move?(row, col)
  row.between?(0, 7) && col.between?(0, 7)
end

# iterate through all possible moves from current location
def find_path(node, finish, queue, moves)
  i = moves[0].length - 1
  while i >= 0
    row = node.location[0] + moves[0][i]
    col = node.location[1] + moves[1][i]
    i -= legal_move?(row, col) ? 1 : 2
    # create node and insert into queue
    return node if [row, col] == finish

    queue << new_node = Node.new([row, col], node.distance + 1, node)
  end
  # recursively search until path found
  new_node.location == finish ? return : find_path(queue.pop, finish, queue, moves)
end

# searches the node tree to print the location of the knight from each node
def print_path(node, path = [])
  node.predecessor.nil? ? node.location : print_path(node.predecessor, path)
  path << node.location
end

# accepts coordinates to find path -- main function
def possible_moves(start, finish, q = Queue.new, moves)
  Board.new.make_board
  q << node = Node.new(start)

  answer = find_path(node, finish, q, moves)
  path = print_path(answer)
  path << finish
end
