local iron = require('iron')

iron.core.add_repl_definitions {
  julia = {
    mycustom = {
      command = {"julia"}
    }
  },
}

iron.core.set_config {
  preferred = {
    julia = "julia",
  },
  repl_open_cmd = "belowright 10 split",
}
