Square = Struct.new(:x, :y, :depth, :parent, :children)

class MoveTree

  attr_reader :squares, :root

  def initialize(coord = [0,0], max_depth = 1)

    @nodes = 0
    @start = coord
    @root = root_init
    @max_depth = max_depth

    create_tree(1, @root)

  end

  def root_init

    @nodes += 1
    Square.new(@start[0], @start[1], 0)

  end

  def create_tree(depth, parent_node)

    return if depth > @max_depth
    parent_node.children = valid_moves([parent_node.x, parent_node.y], depth, parent_node)
    parent_node.children.each do |child|
      create_tree(depth + 1, child)

    end

  end

  def valid_moves(start, depth, parent_node)

    moves = [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]

    valid_moveset = []

    moves.each do |move|
      temp = [start[0] + move[0], start[1] + move[1]]
      if bounds(temp) && prev_move_check(parent_node, temp)
        @nodes += 1
        valid_moveset << Sqaure.new(temp[0], temp[1], dpeth, parent_node)
      end
    end

    valid_moveset
  end

  def inspect

    puts "Your tree has #{@nodes} nodes and a maximum depth of #{max_depth}"

  end

  def prev_move_check(parent_node, temp)
    # ensures that parent node is not included in array of valid moves

    temp_x, temp_y = temp[0], temp[1]
    return true if parent_node == @root

    (parent_node.parent.x != temp_x) && (parent_node.parent.y != temp_y)

  end

  def bounds(coord)

    (0..7).include?(coord[0]) && (0..7).include?(coord[1])

  end

end