class Node
  let children: ((Node, Node) | None)

  new create(depth: USize, env: Env) =>
    if depth > 0 then
      children = (Node.create(depth - 1, env), Node.create(depth - 1, env))
    else
      children = None
    end

  fun count(): USize =>
    match children
    | None => 1
    | (let left: Node box, let right: Node box) => 1 + left.count() + right.count()
    end
