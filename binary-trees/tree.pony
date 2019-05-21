class Tree
  let children: ((Tree val, Tree val) | None)

  new val create(depth: USize) =>
    if depth > 0 then
      children = (Tree.create(depth - 1), Tree.create(depth - 1))
    else
      children = None
    end

  fun count(): USize =>
    match children
    | None => 1
    | (let left: Tree val, let right: Tree val) => 1 + left.count() + right.count()
    end
