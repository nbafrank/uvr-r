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
