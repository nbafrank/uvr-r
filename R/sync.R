#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @param timeout Per-package installation timeout.
#'   Temporally overrides the `UVR_INSTALL_TIMEOUT` environment variable.
#'   Expects a duration string such as \code{30m}, \code{2h}, \code{90s}, or a
#'   bare number representing seconds (e.g. \code{1800}).
#'   Defaults to \code{NULL}, which uses `UVR_INSTALL_TIMEOUT` if set,
#'   or 30 minutes otherwise.
#' @param lib_dir Path to the library directory where to install packages. Defaults
#'   to `NULL`, which uses the `UVR_LIBRARY` environment variable if set, or
#'   the project-level `".uvr/library/"` otherwise.
#' @param show_progress If \code{TRUE}, show a progress bar/spinner while running.
#'   Defaults to \code{TRUE} if \code{interactive()} and `UVR_PROGRESS`
#'   environment variable is not set (unless \code{quiet} is \code{TRUE}).
#' @inheritParams run_uvr
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' sync()
#' sync(frozen = TRUE)  # CI mode: fail if lockfile is stale
#' sync(show_progress = FALSE) # suppress progress bar
#' sync(show_progress = TRUE) # force progress bar
#' }
sync <- function(
  frozen = FALSE,
  timeout = NULL,
  bin = NULL,
  dir = NULL,
  lib_dir = NULL,
  cache_dir = NULL,
  quiet = FALSE,
  show_progress = !quiet &&
    interactive() &&
    is.na(Sys.getenv("UVR_PROGRESS", unset = NA))
) {
  stopifnot(
    is.null(timeout) ||
      (is.character(timeout) && length(timeout) == 1) ||
      (is.numeric(timeout) && length(timeout) == 1)
  )
  .validate_flags(
    list(frozen = frozen, quiet = quiet, show_progress = show_progress)
  )
  .validate_single_characters(
    list(bin = bin, dir = dir, lib_dir = lib_dir, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .temp_setenv(list(
    UVR_LIBRARY = lib_dir,
    UVR_CACHE_DIR = cache_dir,
    UVR_PROGRESS = show_progress,
    UVR_INSTALL_TIMEOUT = timeout
  ))

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
