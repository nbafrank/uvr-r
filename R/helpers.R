#' Get the name of the uvr binary
#' @return Name of the uvr binary (either "uvr" or "uvr.exe").
#' @keywords internal
.get_bin_name <- function() {
  if (.Platform$OS.type == "windows") {
    "uvr.exe"
  } else {
    "uvr"
  }
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
    Sys.getenv("USERPROFILE")
  } else {
    Sys.getenv("HOME")
  }
}
