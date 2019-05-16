use "collections"
use "time"

class Runner is TimerNotify
  let min_depth: USize = 4
  let max_depth: USize
  let _env: Env

  new iso create(depth: USize, env: Env) =>
    max_depth = if (min_depth + 2) > depth then min_depth + 2 else depth end
    _env = env

  fun ref apply(timer: Timer, count: U64): Bool =>
    build_stretch_tree(max_depth + 1)

    let long_lived_tree = Node.create(max_depth, _env)

    for depth in Range(min_depth, max_depth + 1, 2) do
      build_trees(depth)
    end

    _env.out.print("long lived tree of depth " + max_depth.string() + "\t check: " + long_lived_tree.count(_env).string())
    true

  fun build_stretch_tree(depth: USize) =>
    let tree = Node.create(depth, _env)
    _env.out.print("stretch tree of depth " + depth.string() + "\t check: " + tree.count(_env).string())

  fun build_trees(depth: USize) =>
    let iterations: USize = 1 << ((max_depth - depth) + min_depth)
    var sum: USize = 0

    for i in Range(1, iterations + 1) do
      sum = sum + Node.create(depth, _env).count(_env)
    end

    _env.out.print(iterations.string() + "\t trees of depth " + depth.string() + "\t check: " + sum.string())
