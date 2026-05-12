# init works

    Code
      cat(paste(readLines(file.path(temp_dir, ".Rprofile")), collapse = "\n"))
    Output
      # >>> uvr >>>
      local({
        lib <- file.path(getwd(), ".uvr", "library")
        lock <- file.path(getwd(), "uvr.lock")
        rver_file <- file.path(getwd(), ".r-version")
        count_locked <- function(path) {
          if (!file.exists(path)) return(0L)
          length(grep("^\\[\\[package\\]\\]", readLines(path, warn = FALSE)))
        }
        # #70 follow-up: warn when the active R session minor doesn't match
        # the project's `.r-version` pin. The CLI's `uvr sync` already refuses
        # to wipe-and-rebuild on a minor mismatch since v0.2.19, but a user
        # who *just* opens R against the project (no sync yet) wouldn't see
        # that warning and could be running scripts under the wrong R for
        # ages. Surface it at session startup so the mismatch is visible
        # immediately.
        #
        # Post-bundle review: when the version is mismatched, suppress the
        # library-status messages below — otherwise the user sees both
        # "R 4.5 active but pin is 4.6" and "Run uvr::sync() to install"
        # and chases the wrong fix (running sync would build packages for
        # the wrong R). Show the version warning alone; library messages
        # become useful again once they restart R against the pin.
        version_ok <- TRUE
        if (file.exists(rver_file)) {
          pinned <- tryCatch(trimws(readLines(rver_file, warn = FALSE)[1]),
                             error = function(e) "")
          if (nzchar(pinned)) {
            active <- as.character(getRversion())
            pinned_minor <- paste(strsplit(pinned, "\\.")[[1]][1:2], collapse = ".")
            active_minor <- paste(strsplit(active, "\\.")[[1]][1:2], collapse = ".")
            if (pinned_minor != active_minor) {
              message("uvr: R ", active, " active but .r-version pins ", pinned,
                      ". Restart R against the pinned version, or run uvr::r_pin() to change the pin.")
              version_ok <- FALSE
            }
          }
        }
        if (version_ok) {
          if (dir.exists(lib)) {
            # #17: `.libPaths(lib)` with a single new path causes R to drop the
            # user's site library (e.g. ~/R/x86_64-pc-linux-gnu-library/4.4) —
            # only the new path and the system library survive. Prepending via
            # `unique(c(lib, .libPaths()))` keeps the project lib first (so it
            # wins resolution) while preserving anything the user already had.
            .libPaths(unique(c(lib, .libPaths())))
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
        }
      })
      # <<< uvr <<<

