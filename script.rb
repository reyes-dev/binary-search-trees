class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end
# accepts an array when initialized, has a root attribute
class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr
  end
  # build_tree takes an array of data and turns it into a balanced binary tree full of
  # Node objects appropriately placed, sorted, with duplicates removed
  # build_tree should return the level-0 root node (:root)
  # first and last are idx
  def build_tree(arr, first, last)
    return nil if first > last # base condition
    # middle of array -- root index
    mid = (first + last) / 2
    if @root.nil? # for the very first node and level 0 root
      @root = Node.new(arr[mid]) # level 0 root
      # recursively set the left/right child attributes of @root node
      @root.left_child = build_tree(arr, first, (mid - 1))
      @root.right_child = build_tree(arr, (mid + 1), last)
      # returns the level 0 root Node
      @root
    else
      # level 1+ nodes are roots of their own children
      # but they are given a normal variable instead of an instance variable
      # in order to avoid overriding the instance variable which must hold level 0 root
      root = Node.new(arr[mid])
      # recursively set children of root nodes
      # hits base condition of 'first > last' I.E. their children are nil/non-existent
      root.left_child = build_tree(arr, first, (mid - 1))
      root.right_child = build_tree(arr, (mid + 1), last)
      # returns the new root Node
      root
    end
  end
  # accepts a value to insert into the tree
  def insert(value)
    node = @root

    loop do
      if value < node.data
        if node.left_child.nil?
          node.left_child = Node.new(value)
          break
        else
          node = node.left_child
        end
      elsif value > node.data
        if node.right_child.nil?
          node.right_child = Node.new(value)
          break
        else
          node = node.right_child
        end
      end
    end
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

array = [1, 2, 3].sort.uniq
tree = Tree.new(array)
tree.build_tree(array, 0, (array.length - 1))

tree.insert(5)
tree.insert(4)

p tree