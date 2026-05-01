#' Get the name of the uvr binary
#' @param os_type OS type, defaults to \code{.Platform$OS.type}.
#' @return Name of the uvr binary (either "uvr" or "uvr.exe").
#' @keywords internal
.get_bin_name <- function(os_type = .Platform$OS.type) {
  if (os_type == "windows") "uvr.exe" else "uvr"
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
