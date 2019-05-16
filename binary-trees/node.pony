class Node
  let children: ((Node, Node) | None)

  new create(depth: USize) =>
    if depth > 0 then
      children = (Node.create(depth - 1), Node.create(depth - 1))
    else
      children = None
    end

  fun count(): USize =>
    match children
    | None => 1
    | (let left: Node box, let right: Node box) => 1 + left.count() + right.count()
    end
