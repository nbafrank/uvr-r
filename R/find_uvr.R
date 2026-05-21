#' Find the uvr binary
#'
#' Searches for the \code{uvr} executable on the system PATH and common
#' installation locations. Stops with a helpful message if not found.
#'
#' @inheritParams .find_uvr_path
#' @return The path to the \code{uvr} binary (character string).
#' @keywords internal
find_uvr <- function(check_path = TRUE) {
  path <- .find_uvr_path(check_path = check_path)
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
#' @inheritParams install_uvr
#' @param check_path If \code{TRUE}, check the PATH first.
#' @return Path string or NULL if not found.
#' @keywords internal
.find_uvr_path <- function(install_dir = .get_home_dir(), check_path = TRUE) {
  bin_name <- .get_bin_name()

  # Check PATH first
  path <- Sys.which(bin_name)
  if (check_path && nzchar(path) && file.exists(path)) {
    return(unname(path))
  }

  # Check common install locations
  candidates <- install_dir |>
    file.path(c(".cargo", ".local"), "bin", bin_name)
  if (.Platform$OS.type == "windows") {
    appdata_path <- Sys.getenv("LOCALAPPDATA") |>
      file.path("Programs", "uvr", bin_name)
    candidates <- c(candidates, appdata_path)
  } else {
    candidates <- c(
      candidates,
      "/usr/local/bin/uvr",
      "/opt/homebrew/bin/uvr" # Apple Silicon Homebrew
    )
  }
  for (candidate in candidates) {
    if (file.exists(candidate)) return(candidate)
  }

  invisible()
}
