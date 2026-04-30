#' Find the uvr binary
#'
#' Searches for the \code{uvr} executable on the system PATH and common
#' installation locations. Stops with a helpful message if not found.
#'
#' @return The path to the \code{uvr} binary (character string).
#' @keywords internal
find_uvr <- function() {
  # Return cached result if available
  cached <- .uvr_env$bin
  if (!is.null(cached)) return(cached)

  path <- .find_uvr_path()
  if (!is.null(path)) {
    .uvr_env$bin <- path
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
  bin_name <- if (.Platform$OS.type == "windows") "uvr.exe" else "uvr"

  # Check PATH first
  path <- Sys.which(bin_name)
  if (nzchar(path)) return(unname(path))

  # Check common install locations
  if (.Platform$OS.type == "windows") {
    candidates <- file.path(Sys.getenv("USERPROFILE"), ".cargo", "bin", "uvr.exe")
    local_app <- Sys.getenv("LOCALAPPDATA")
    if (nzchar(local_app)) {
      candidates <- c(candidates, file.path(local_app, "Programs", "uvr", "uvr.exe"))
    }
  } else {
    candidates <- c(
      file.path(Sys.getenv("HOME"), ".cargo", "bin", "uvr"),
      "/usr/local/bin/uvr"
    )
  }
  for (candidate in candidates) {
    if (file.exists(candidate)) return(candidate)
  }

  NULL
}

# Package-level cache for binary path
.uvr_env <- new.env(parent = emptyenv())

#' Run a uvr CLI command
#'
#' Internal helper that invokes uvr with the given arguments and streams
#' output to the R console.
#'
#' @param args Character vector of CLI arguments.
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress all output.
#' @return Invisible \code{TRUE} on success.
#' @keywords internal
run_uvr <- function(args, dir = NULL, quiet = FALSE) {
  bin <- find_uvr()

  if (!is.null(dir)) {
    old_wd <- setwd(dir)
    on.exit(setwd(old_wd), add = TRUE)
  }

  if (isTRUE(quiet)) {
    rc <- system2(bin, args, stdout = FALSE, stderr = FALSE)
  } else {
    rc <- system2(bin, args, stdout = "", stderr = "")
  }

  if (rc != 0L) {
    stop("uvr exited with code ", rc, call. = FALSE)
  }
  invisible(TRUE)
}
