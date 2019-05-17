class Node
  let children: ((Node val, Node val) | None)

  new val create(depth: USize) =>
    if depth > 0 then
      children = (Node.create(depth - 1), Node.create(depth - 1))
    else
      children = None
    end

  fun count(): USize =>
    match children
    | None => 1
    | (let left: Node val, let right: Node val) => 1 + left.count() + right.count()
    end
