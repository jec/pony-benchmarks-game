use "collections"

actor Builder
  let iterations: USize
  let depth: USize
  let _main: Main
  var _count: USize = 0
  var _sum: USize = 0

  new create(iterations': USize, depth': USize, main: Main) =>
    iterations = iterations'
    depth = depth'
    _main = main
    build_tree()

  be build_tree() =>
    let tree: Tree val = Tree.create(depth)
    _count = _count + 1
    _sum = _sum + tree.count()

    if _count == iterations then
      _main.builder_done(if iterations == 1 then tree else None end, iterations, depth, _sum)
    else
      build_tree()
    end
