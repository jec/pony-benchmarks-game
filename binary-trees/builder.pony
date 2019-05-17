use "collections"

actor Builder
  let iterations: USize
  let depth: USize
  let _main: Main
  let _env: Env

  new create(iterations': USize, depth': USize, main: Main, env: Env) =>
    env.out.print("Creating Builder(" + iterations'.string() + ", " + depth'.string() + ", <main>)")

    iterations = iterations'
    depth = depth'
    _main = main
    _env = env
    build_trees()

  be build_trees() =>
    var sum: USize = 0
    let trees: Array[Node val] = Array[Node val](iterations)

    for i in Range(1, iterations + 1) do
      let tree: Node val = Node.create(depth)
      sum = sum + tree.count()
      trees.push(tree)
    end

    _main.builder_done(recover val trees end, iterations, depth, sum, this)

  fun _final() =>
    _env.out.print("Finalizing Builder(" + iterations.string() + ", " + depth.string() + ", <main>)")
