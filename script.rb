class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child


end

class Tree

  attr_accessor :root

  def initialize(arr)
    @arr = arr
  end
  # build_tree takes an array of data and turns it into a balanced binary tree full of 
  # Node objects appropriately placed, sorted, with duplicates removed
  # build_tree should return the level-0 root node (:root)
  def build_tree(arr)
  end
  # accepts a value to insert into the tree
  def insert(value)
  end
  # accepts a value to delete from the tree
  # will have to deal with several cases such as when a node has children or not
  def delete(value)
  end
  # accepts a value and returns the node with it 
  def find(value)
  end
  # accepts a block
  # traverses tree in breadth-first level order 
  # yields each node to the provided block
  # use either iteration, recursion or both
  # return an array of values if no block is given
  # use an array, acting as a queue, to keep track of all the child nodes 
  # that you have yet to traverse
  # and to add new ones to the list
  def level_order
  end
  # inorder, preorder, and postorder all accept a block
  # they all traverse the tree in their respective depth-first order
  # yielding each node to the provided block
  # the methods all return an array of values if no block is given
  def inorder(block)
  end

  def preorder(block)
  end

  def postorder(block)
  end
  # accepts a node and returns its height
  # height is defined as the number of edges in longest path from a given node to a leaf node
  def height(node)
  end
  # accepts a node and returns its depth
  # depth is defined as the number of edges in path from a given node to the tree's root node
  def depth(node)
  end
  # checks if the tree is balanced 
  # a balanced tree is one where the difference between heights of 
  # left subtree and right subtree of every node is not more than 1
  def balanced?
  end
  # rebalances and unbalanced tree
  # use a traversal method to provide a new array to the build_tree method
  def rebalance
  end
end