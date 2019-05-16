use "collections"

actor Main
  let min_depth: USize = 4
  var _long_lived_tree: ((Node, USize) | None) = None
  let _depths: Set[USize] = Set[USize]
  let _env: Env

  new create(env: Env) =>
    _env = env

    match try env.args(1)?.usize()? else None end
    | let depth: USize =>
        let max_depth: USize = if (min_depth + 2) > depth then min_depth + 2 else depth end
        build_stretch_tree(max_depth)
    | None =>
        env.err.print("First argument was not an integer.")
    end

  be build_stretch_tree(depth: USize) =>
    let tree = Node.create(depth + 1)
    _env.out.print("stretch tree of depth " + (depth + 1).string() + "\t check: " + tree.count().string())
    build_long_lived_tree(depth)

  be build_long_lived_tree(depth: USize) =>
    _long_lived_tree = (Node.create(depth), depth)
    build_trees(depth)

  be build_trees(max_depth: USize) =>
    for depth in Range(min_depth, max_depth + 1, 2) do
      _depths.set(depth)
      Builder(1 << ((max_depth - depth) + min_depth), depth, this)
    end

  be builder_done(iterations: USize, depth: USize, size: USize) =>
    _depths.unset(depth)
    _env.out.print(iterations.string() + "\t trees of depth " + depth.string() + "\t check: " + size.string())

    if _depths.size() == 0 then
      match _long_lived_tree
      | (let tree: Node, let tree_depth: USize) =>
          _env.out.print("long lived tree of depth " + tree_depth.string() + "\t check: " + tree.count().string())
      | None => None
      end
    end
