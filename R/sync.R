#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @param lib_dir Path to the library directory where to install packages. Defaults
#'   to `NULL`, which uses the `UVR_LIBRARY` environment variable if set, or
#'   the project-level `".uvr/library/"` otherwise.
#' @inheritParams run_uvr
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' sync()
#' sync(frozen = TRUE)  # CI mode: fail if lockfile is stale
#' }
sync <- function(
  frozen = FALSE,
  bin = NULL,
  dir = NULL,
  lib_dir = NULL,
  cache_dir = NULL,
  quiet = FALSE
) {
  .validate_flags(list(frozen = frozen, quiet = quiet))
  .validate_single_characters(
    list(bin = bin, dir = dir, lib_dir = lib_dir, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .temp_setenv(list(UVR_LIBRARY = lib_dir, UVR_CACHE_DIR = cache_dir))

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
