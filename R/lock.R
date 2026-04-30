#' Update the lockfile
#'
#' Re-resolves all dependencies and writes \code{uvr.lock} without installing.
#' Equivalent to \code{uvr lock}.
#'
#' @param upgrade If \code{TRUE}, upgrade all packages to their latest allowed
#'   versions.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
#' @examples
#' \dontrun{
#' lock()
#' lock(upgrade = TRUE)  # upgrade all packages to latest versions
#' }
lock <- function(upgrade = FALSE, dir = NULL, quiet = FALSE) {
  args <- "lock"
  if (isTRUE(upgrade)) {
    args <- c(args, "--upgrade")
  }
  run_uvr(args, dir = dir, quiet = quiet)
}
