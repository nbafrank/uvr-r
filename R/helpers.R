#' Get the name of a binary for Unix or Windows (+".exe")
#' @param name Name of binary to return OS-specific name for (default: "uvr")
#' @param os_type OS type, defaults to \code{.Platform$OS.type}.
#' @return OS-specific name of the binary (i.e. "uvr" or "uvr.exe").
#' @keywords internal
.get_bin_name <- function(name = "uvr", os_type = .Platform$OS.type) {
  paste0(name, if (os_type == "windows") ".exe" else "")
}

#' Return HOME/USER directory
#'
#' Internal helper that returns the user's home directory.
#' (Windows: \code{USERPROFILE}, Unix: \code{HOME})
#'
#' @return Path to user's home directory.
#' @keywords internal
.get_home_dir <- function() {
  if (.Platform$OS.type == "windows") {
    home <- Sys.getenv("USERPROFILE")
  } else {
    home <- Sys.getenv("HOME")
  }

  if (!nzchar(home)) {
    home <- path.expand("~")
  }

  return(home)
}

#' Swap out NULL values with another value
#' @return y if x is NULL, otherwise x
#' @keywords internal
`%||%` <- function(x, y) if (is.null(x)) y else x

#' Run a terminal command and capture the output cleanly
#' @param bin Path to the binary to run
#' @param args Arguments to pass to the binary
#' @param quiet If \code{TRUE}, suppress output from the binary
#' @return A list with elements \code{stdout}, \code{stderr}, and \code{return_code}, captured from the process.
#' @keywords internal
.run_and_capture <- function(bin, args, quiet = FALSE) {
  proc <- processx::process$new(
    bin,
    args,
    stdout = "|", # pipe so we can read programmatically
    stderr = "|"
  )

  stdout_lines <- character(0)
  stderr_lines <- character(0)

  # Poll while process is alive
  while (proc$is_alive()) {
    # Read whatever is available right now (non-blocking)
    out <- proc$read_output_lines()
    err <- proc$read_error_lines()

    if (length(out)) {
      stdout_lines <- c(stdout_lines, out)
      if (!quiet) cat(out, sep = "\n")
    }
    if (length(err)) {
      stderr_lines <- c(stderr_lines, err)
      if (!quiet) {
        cat(paste(err, collapse = "\n"), "\n", file = stderr(), sep = "")
      }
    }
  }

  # Drain any remaining output after process exits
  out <- proc$read_output_lines()
  err <- proc$read_error_lines()
  if (length(out)) {
    stdout_lines <- c(stdout_lines, out)
    if (!quiet) cat(out, sep = "\n")
  }
  if (length(err)) {
    stderr_lines <- c(stderr_lines, err)
    if (!quiet) message(paste(err, collapse = "\n"))
  }

  list(
    stdout = stdout_lines,
    stderr = stderr_lines,
    return_code = proc$get_exit_status()
  )
}
