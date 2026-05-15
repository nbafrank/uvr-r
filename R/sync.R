#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
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
  quiet = FALSE
) {
  stopifnot(
    is.logical(frozen) && !is.na(frozen) && length(frozen) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.null(cache_dir) || (is.character(cache_dir) && length(cache_dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  .setup_cache_dir(cache_dir)

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
