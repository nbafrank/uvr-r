#' Find the uvr binary
#'
#' Searches for the \code{uvr} executable on the system PATH and common
#' installation locations. Stops with a helpful message if not found.
#'
#' @return The path to the \code{uvr} binary (character string).
#' @keywords internal
find_uvr <- function() {
  path <- .find_uvr_path()
  if (!is.null(path)) {
    return(path)
  }

  if (interactive()) {
    message("The 'uvr' binary was not found on this system.")
    ans <- readline("Would you like to install it now? (Y/n) ")
    if (!nzchar(ans) || tolower(substr(ans, 1, 1)) == "y") {
      path <- install_uvr()
      return(path)
    }
  }

  stop(
    "Could not find the 'uvr' binary.\n",
    "Install it from R with: uvr::install_uvr()\n",
    "Or from the terminal: cargo install --git https://github.com/nbafrank/uvr",
    call. = FALSE
  )
}

#' Search common locations for the uvr binary
#' @return Path string or NULL if not found.
#' @keywords internal
.find_uvr_path <- function() {
  bin_name <- .get_bin_name()

  # Check PATH first
  path <- Sys.which(bin_name)
  if (nzchar(path)) {
    return(unname(path))
  }

  # Check common install locations
  candidates <- file.path(.get_home_dir(), ".cargo", "bin", bin_name)
  if (.Platform$OS.type == "windows") {
    appdata_path <- Sys.getenv("LOCALAPPDATA") |>
      file.path("Programs", "uvr", bin_name)
    candidates <- c(candidates, appdata_path)
  } else {
    candidates <- c(candidates, "/usr/local/bin/uvr")
  }
  for (candidate in candidates) {
    if (file.exists(candidate)) return(candidate)
  }

  invisible()
}

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
