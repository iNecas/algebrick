# define algebraic types
Tree = Algebrick.type do |tree|
  variants Empty = atom,
           Leaf  = type { fields Integer },
           Node  = type { fields tree, tree }
end                                                # => Tree(Empty | Leaf | Node)

# add some methods
module Tree
  # compute depth of a tree
  def depth
    match self,
          Empty >> 0,
          Leaf >> 1,
          # ~ will store and pass matched parts to variables left and right
          Node.(~any, ~any) >-> left, right do
            1 + [left.depth, right.depth].max
          end
  end
end                                                # => nil

# methods are defined on all values of type Tree
Empty.depth                                        # => 0
Leaf[10].depth                                     # => 1
Node[Leaf[4], Empty].depth                         # => 2
Node[Empty, Node[Leaf[1], Empty]].depth            # => 3
