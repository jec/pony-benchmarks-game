use "collections"

actor Main
  let min_depth: USize = 4
  var max_depth: USize = 0
  var state: State = Init
  let env: Env

  var _long_lived_tree: (Node val | None) = None
  let _pending: Set[USize] = Set[USize]

  new create(env': Env) =>
    env = env'

    match try env.args(1)?.usize()? else None end
    | let depth: USize =>
        max_depth = if (min_depth + 2) > depth then min_depth + 2 else depth end
        // build stretch tree
        Builder(1, max_depth + 1, this, env)
    | None =>
        env.err.print("First argument was not an integer.")
    end

  be builder_done(trees: Array[Node val] val, iterations: USize, depth: USize, size: USize, builder: Builder) =>
    match state
    | Init =>
        state = StretchDone
        match try trees(0) else None end
        | None => None
        | let tree: Node val =>
            env.out.print("stretch tree of depth " + size.string() + "\t check: " + tree.count().string())
        end

        // build long-lived tree
        Builder(1, max_depth, this, env)
    | StretchDone =>
        state = LongLivedDone
        _long_lived_tree = try trees(0) else None end

        // build trees
        for d in Range(min_depth, max_depth + 1, 2) do
          _pending.set(d)
          Builder(1 << ((max_depth - d) + min_depth), d, this, env)
        end
    | LongLivedDone =>
        // remove from pending
        _pending.unset(depth)
        env.out.print(iterations.string() + "\t trees of depth " + depth.string() + "\t check: " + size.string())

        // check if all depths are done
        if _pending.size() == 0 then
          match _long_lived_tree
          | let tree: Node val =>
              env.out.print("long lived tree of depth " + max_depth.string() + "\t check: " + tree.count().string())
          | None => None
          end
        end
    end
