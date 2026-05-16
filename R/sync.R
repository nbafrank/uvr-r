#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @param ignore_cache If \code{TRUE}, ignore the cache when downloading and installing packages.
#'   Still populates the cache for future installs regardless.
#'   Default: \code{FALSE}.
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
  cache_dir = NULL,
  ignore_cache = FALSE,
  quiet = FALSE
) {
  .validate_flags(
    list(frozen = frozen, quiet = quiet, ignore_cache = ignore_cache)
  )
  .validate_single_characters(
    list(bin = bin, dir = dir, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .setup_cache_dir(cache_dir)

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  if (isTRUE(ignore_cache)) {
    args <- c(args, "--ignore-cache")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
