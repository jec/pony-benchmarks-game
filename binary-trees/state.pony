primitive Init
  fun string() => "Init"

primitive StretchDone
  fun string() => "StretchDone"

primitive LongLivedDone
  fun string() => "LongLivedDone"

type State is (Init | StretchDone | LongLivedDone)
