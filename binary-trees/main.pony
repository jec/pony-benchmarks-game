use "collections"

actor Main
  let min_depth: USize = 4
  var max_depth: USize = 0
  var state: State = Init
  let env: Env

  var _long_lived_tree: (Tree val | None) = None
  let _queue: Array[USize] = Array[USize]
  let _pending: Set[USize] = Set[USize]

  new create(env': Env) =>
    env = env'

    match try env.args(1)?.usize()? else None end
    | let depth: USize =>
        max_depth = if (min_depth + 2) > depth then min_depth + 2 else depth end
        // build stretch tree
        Builder(1, max_depth + 1, this)
    | None =>
        env.err.print("First argument was not an integer.")
    end

  be builder_done(tree: (Tree val | None), iterations: USize, depth: USize, size: USize) =>
    match state
    | Init =>
        state = StretchDone
        match tree
        | None => None
        | let t: Tree val =>
            env.out.print("stretch tree of depth " + size.string() + "\t check: " + t.count().string())
        end

        // build long-lived tree
        Builder(1, max_depth, this)
    | StretchDone =>
        state = LongLivedDone
        _long_lived_tree = tree

        // create queue of depths to run
        for d in Range(min_depth, max_depth + 1, 2) do
          _queue.push(d)
        end

        // run first depth
        start_next_builder()
    | LongLivedDone =>
        env.out.print(iterations.string() + "\t trees of depth " + depth.string() + "\t check: " + size.string())

        // remove from pending
        _pending.unset(depth)

        // check if all depths are done
        if _pending.size() == 0 then
          match _long_lived_tree
          | None => None
          | let t: Tree val =>
              env.out.print("long lived tree of depth " + max_depth.string() + "\t check: " + t.count().string())
          end
        end
    end

  be start_next_builder() =>
    match try _queue.shift()? else None end
    | None => None
    | let d: USize =>
        _pending.set(d)
        Builder(1 << ((max_depth - d) + min_depth), d, this)
        start_next_builder()
    end
