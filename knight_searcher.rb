require_relative 'movetree'

#t = MoveTrees.new([3,3], 5)

class Knightsearcher
   attr_accessor :tree
   def initialize(t)
       @tree = t.tree
   end
   
   def bfs_for(coords)

      queue = [] << @tree
      while queue.length != 0 do
         if [queue[0].x, queue[0].y] == coords
             return queue[0].path
         elsif [queue[0].x, queue[0].y] != coords
             if queue[0].children != nil
                    queue[0].children.each do |child|
                    queue << child 
                    end
             end
         queue.shift
         end
      end
      return "not found"

   end
   
   def dfs_for(coords)

      stack = [] << @tree
      while stack.length != 0 do
         if stack[stack.length - 1].x == coords[0] && stack[stack.length - 1].y == coords[1]
            return stack[stack.length - 1].path
         else
            last = stack[stack.length - 1]
            stack.pop
            if last.children != nil
               last.children.each do |child|
                  stack << child
               end
            end
         end
      end
      return "not found"
      
   end
   
    
end

# compare computation times
t = MoveTrees.new([3, 3], 5)
k = Knightsearcher.new(t)
t1 = Time.now
1.upto(5) do |x|
  1.upto(5) do |y|
     k.bfs_for([x, y])
  end
end
t2 = Time.now
delta1 = t2 - t1
t3 = Time.now
1.upto(5) do |x|
  1.upto(5) do |y|
     k.dfs_for([x, y])
  end
end
t4 = Time.now
delta2 = t4 - t3
puts "BFS use #{delta1}"
puts "DFS use #{delta2}"

tree = MoveTrees.new([3,3], 7)
searcher = Knightsearcher.new(tree)
print searcher.bfs_for([8,8]).to_s + "\n"
print searcher.dfs_for([8,8]).to_s + "\n"