# init works

    Code
      cat(paste(readLines(file.path(temp_dir, ".Rprofile")), collapse = "\n"))
    Output
      # >>> uvr >>>
      local({
        lib <- file.path(getwd(), ".uvr", "library")
        lock <- file.path(getwd(), "uvr.lock")
        count_locked <- function(path) {
          if (!file.exists(path)) return(0L)
          length(grep("^\\[\\[package\\]\\]", readLines(path, warn = FALSE)))
        }
        if (dir.exists(lib)) {
          .libPaths(lib)
          n_locked <- count_locked(lock)
          installed <- list.dirs(lib, recursive = FALSE, full.names = FALSE)
          n_installed <- length(setdiff(installed, "uvr"))
          if (n_locked > 0 && n_installed < n_locked) {
            message("uvr: ", n_locked - n_installed, " of ", n_locked,
                    " package(s) not installed. Run uvr::sync() to install.")
          } else if (n_locked > 0) {
            message("uvr: library linked (", n_installed, " packages)")
          } else if (file.exists(lock)) {
            message("uvr: library active, but uvr.lock is empty. Run uvr::lock() to populate it.")
          } else {
            message("uvr: library active, but no uvr.lock found. Run uvr::lock() to create one.")
          }
        } else if (file.exists(lock)) {
          # #59: .uvr/library/ doesn't exist yet but the lockfile does — fresh
          # checkout, never synced. Tell the user.
          n_locked <- count_locked(lock)
          message("uvr: 0 of ", n_locked, " package(s) installed. Run uvr::sync() to install.")
        }
      })
      # <<< uvr <<<

