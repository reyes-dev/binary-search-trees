require 'pry-byebug'

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
  attr_accessor :root, :arr

  def initialize(arr)
    @arr = arr.sort.uniq
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
      return nil if value == node.data

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
  def min_val_node(node)
    current = node

    until current.left_child.nil?
      current = current.left_child
    end

    current
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      # if node has one child or zero children
      return node.right_child if node.left_child.nil?
      return node.left_child if node.right_child.nil?
      # if node has two children
      leftmost_node = min_val_node(node.right_child)
      node.data = leftmost_node.data
      node.right_child = delete(leftmost_node.data, node.right_child)
    end
    node
  end

  # accepts a value and returns the node with it
  def find(value)
    node = @root

    begin
    loop do
      break node if node.data == value
      value < node.data ? node = node.left_child : node = node.right_child
    end
    rescue
      false
    end
  end
  # accepts a block
  # traverses tree in breadth-first level order
  # yields each node to the provided block
  # use either iteration, recursion or both
  # return an array of values if no block is given
  # use an array, acting as a queue, to keep track of all the child nodes
  # that you have yet to traverse
  # and to add new ones to the list
  def level_order(node, &block)
    return @arr unless block_given?
    return if node.nil?

    queue = []
    queue.push(node)

    until queue.empty?
      current = queue[0]
      block.call(current)
      queue.push(current.left_child) unless current.left_child.nil?
      queue.push(current.right_child) unless current.right_child.nil?
      queue.shift
    end
    # level_order(node.left_child, &block)
    # level_order(node.right_child, &block)
  end
  # inorder, preorder, and postorder all accept a block
  # they all traverse the tree in their respective depth-first order
  # yielding each node to the provided block
  # the methods all return an array of values if no block is given
  # IN ORDER
  def inorder(node, &block)
    return @arr unless block_given?
    return if node.nil?

    inorder(node.left_child, &block)
    block.call(node)
    inorder(node.right_child, &block)
  end
  # PRE ORDER
  def preorder(node, &block)
    return @arr unless block_given?
    return if node.nil?

    block.call(node)
    preorder(node.left_child, &block)
    preorder(node.right_child, &block)
  end
  # POST ORDER
  def postorder(node, &block)
    return @arr unless block_given?
    return if node.nil?

    postorder(node.left_child, &block)
    postorder(node.right_child, &block)
    block.call(node)
  end
  # accepts a node and returns its height
  # height is defined as the number of edges in longest path from a given node to a leaf node
  def height(node)
    return -1 if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    [left_height, right_height].max + 1
  end
  # accepts a node and returns its depth
  # depth is defined as the number of edges in path from a given node to the tree's root node
  def depth(node)
    current = @root
    depth = 0

    until current.data == node.data
      if node.data < current.data 
        current = current.left_child
      elsif node.data > current.data
        current = current.right_child
      end

      depth = depth + 1
    end

    depth
  end
  # checks if the tree is balanced by checking if each subtree is balanced
  def balance_check(node, container = [])
    return nil if node.nil?

    container << (height(node.left_child) - height(node.right_child) > 1)
    container << (height(node.right_child) - height(node.left_child) > 1)
    
    balance_check(node.left_child, container)
    balance_check(node.right_child, container)

    container
  end
  # returns true if balanced, false if imbalanced
  # or, if any falses appear during the balance_check method run
  def balanced?(node)
   !balance_check(node).any?(true)
  end
  # rebalances an unbalanced tree
  # use a traversal method to provide a new array to the build_tree method
  def rebalance
    arr = []
    inorder_nodes = Proc.new { |node| arr << node.data }
    self.inorder(self.root, &inorder_nodes)
    new_tree = Tree.new(arr)
    new_tree.build_tree(arr, 0, (arr.length - 1))
    new_tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end

# array = [1, 2, 3].sort.uniq
# tree = Tree.new(array)
# tree.build_tree(array, 0, (array.length - 1))
# tree.root.right_child.right_child = Node.new(4)
# tree.root.right_child.right_child.right_child = Node.new(5)
# tree.pretty_print
# tree = tree.rebalance
# tree.pretty_print
proc = Proc.new { |node| print node }

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.build_tree(tree.arr, 0, (tree.arr.length - 1))
tree.pretty_print

tree.level_order(tree.root, &proc)
tree.preorder(tree.root, &proc)
tree.postorder(tree.root, &proc)
tree.inorder(tree.root, &proc)

tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.insert(104)
tree.pretty_print

p tree.balanced?(tree.root)
tree = tree.rebalance
p tree.balanced?(tree.root)
tree.pretty_print

tree.level_order(tree.root, &proc)
tree.preorder(tree.root, &proc)
tree.postorder(tree.root, &proc)
tree.inorder(tree.root, &proc)