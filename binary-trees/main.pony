use "collections"
use "itertools"

actor Main
  new create(env: Env) =>
    try
      let requested_depth = env.args(1)?.usize()?
      let min_depth: USize = 4
      let max_depth: USize = if (min_depth + 2) > requested_depth then min_depth + 2 else requested_depth end

      build_stretch_tree(max_depth + 1, env)

      let long_lived_tree = Node.create(max_depth)

      for depth in Iter[USize](Range(min_depth, max_depth + 1, 2)) do
        let iterations: USize = 1 << ((max_depth - depth) + min_depth)
        var sum: USize = 0

        for i in Iter[USize](Range(1, iterations + 1)) do
          sum = sum + Node.create(depth).count()
        end

        env.out.print(iterations.string() + "\t trees of depth " + depth.string() + "\t check: " + sum.string())
      end

      env.out.print("long lived tree of depth " + max_depth.string() + "\t check: " + long_lived_tree.count().string())
    else
      env.out.print("First argument was not an integer.")
    end

  fun build_stretch_tree(depth: USize, env: Env) =>
    let tree = Node.create(depth)
    env.out.print("stretch tree of depth " + depth.string() + "\t check: " + tree.count().string())
