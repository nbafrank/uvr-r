#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @inheritParams run_uvr
#' @inheritParams cache_clean
#' @inherit run_uvr return
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
  cache_dir = "~/.uvr/cache/",
  quiet = FALSE
) {
  stopifnot(
    is.logical(frozen) && !is.na(frozen) && length(frozen) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.character(cache_dir) && length(cache_dir) == 1L,
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  if (cache_dir != "~/.uvr/cache/") {
    old_dir <- Sys.getenv("UVR_CACHE_DIR")
    Sys.setenv(UVR_CACHE_DIR = cache_dir)
    on.exit(Sys.setenv(UVR_CACHE_DIR = old_dir), add = TRUE)
  }

  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
