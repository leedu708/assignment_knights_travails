Square = Struct.new(:x,:y,:path,:depth, :children)

class MoveTrees
   attr_accessor :tree, :depth, :max_depth, :nodes
   
   def initialize(coords, depth)

       @max_depth = depth
       @depth = 0
       @tree = Square.new(coords[0], coords[1], [coords], @depth, nil)
       @nodes = [1, 0]
       @tree.children = tree_init(coords, [coords], @depth)

   end
   
   def tree_init(coords, path, input_depth)

       depth = input_depth + 1
       return nil if depth > @max_depth
       moves = []
       movetree = []
       [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]].each do |pair|
            if valid_move?([coords[0] + pair[0], coords[1] + pair[1]], path)
               moves << [coords[0] + pair[0], coords[1] + pair[1]] 
            end
       end
       @nodes[0] += moves.length
       #print moves
       moves.each do |pos|
          son =  Square.new(pos[0], pos[1], path + [pos], depth, nil)
          movetree << son
       end
       #print movetree
       movetree.each do |child|
           child.children = tree_init([child[0], child[1]], child.path, depth)
       end
       @nodes[1] = [depth + 1, nodes[1]].max
       
       return movetree

   end
   
   def valid_move?(coords, path)

      [1,2,3,4,5,6,7,8].include?(coords[0]) && [1,2,3,4,5,6,7,8].include?(coords[1]) && !path.include?(coords)

   end
   
   def inspect
      puts @nodes[0].to_s + "  nodes"
      puts @nodes[1].to_s + "  depth"
   end
    
end