actor Main
  new create(env: Env) =>
    try
      let depth = env.args(1)?.usize()?
      let min_depth: USize = 4
      let max_depth: USize = if (min_depth + 2) > depth then min_depth + 2 else depth end
      build_stretch_tree(max_depth + 1, env)
    else
      env.out.print("First argument was not an integer.")
    end

  fun build_stretch_tree(depth: USize, env: Env) =>
    let tree = Node.create(depth, env)
    env.out.print("stretch tree of depth " + depth.string() + "\t check: " + tree.count().string())
