use "time"

actor Main
  new create(env: Env) =>
    let requested_depth = try env.args(1)?.usize()? else None end

    match try env.args(1)?.usize()? else None end
    | let depth: USize =>
        let timers = Timers
        let timer = Timer(Runner(depth, env), 0, 0)
        timers(consume timer)
    | None =>
        env.err.print("First argument was not an integer.")
        // env.exitcode = 1
    end
