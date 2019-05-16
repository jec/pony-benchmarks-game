use "collections"

actor Builder
  let _main: Main

  new create(iterations: USize, depth: USize, main: Main) =>
    _main = main
    build_trees(iterations, depth)

  be build_trees(iterations: USize, depth: USize) =>
    var sum: USize = 0

    for i in Range(1, iterations + 1) do
      sum = sum + Node.create(depth).count()
    end

    _main.builder_done(iterations, depth, sum)
