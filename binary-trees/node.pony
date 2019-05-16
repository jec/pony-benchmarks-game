class Node
  let children: ((Node, Node) | None)

  new create(depth: USize, env: Env) =>
    // env.out.print("Node.create(" + depth.string() + ")")
    // env.out.write("~")
    if depth > 0 then
      // env.out.print("A")
      children = (Node.create(depth - 1, env), Node.create(depth - 1, env))
    else
      // env.out.print("B")
      children = None
    end

  fun count(env: Env): USize =>
    match children
    | None => 1
    | (let left: Node box, let right: Node box) =>
        // env.out.write("<")
        let left_count = left.count(env)
        // env.out.write(">")
        let right_count = right.count(env)
        // env.out.write(".")
        1 + left_count + right_count
    end
