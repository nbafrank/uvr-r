#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @inheritParams run_uvr
#' @inheritParams add
#' @inheritParams cache_clean
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' sync()
#' sync(frozen = TRUE) # CI mode: fail if lockfile is stale
#' sync(progress = "always") # force spinners even though output is piped
#' }
sync <- function(
  frozen = FALSE,
  bin = NULL,
  dir = NULL,
  cache_dir = NULL,
  progress = NULL,
  quiet = FALSE
) {
  .validate_flags(list(frozen = frozen, quiet = quiet))
  .validate_single_characters(
    list(bin = bin, dir = dir, cache_dir = cache_dir),
    null_ok = TRUE
  )
  .setup_cache_dir(cache_dir)
  .setup_progress(progress)

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
