#' Synchronize project library from lockfile
#'
#' Installs all packages specified in \code{uvr.lock}. Idempotent --- skips
#' packages that are already installed. Equivalent to \code{uvr sync}.
#'
#' @param frozen If \code{TRUE}, fail if the lockfile is out of date (CI mode).
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
#' @examples
#' \dontrun{
#' sync()
#' sync(frozen = TRUE)  # CI mode: fail if lockfile is stale
#' }
sync <- function(frozen = FALSE, dir = NULL, quiet = FALSE) {
  args <- "sync"
  if (isTRUE(frozen)) {
    args <- c(args, "--frozen")
  }
  run_uvr(args, dir = dir, quiet = quiet)
}
