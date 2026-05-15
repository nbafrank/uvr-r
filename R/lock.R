#' Update the lockfile
#'
#' Re-resolves all dependencies and writes \code{uvr.lock} without installing.
#' Equivalent to \code{uvr lock}.
#'
#' @param upgrade If \code{TRUE}, upgrade all packages to their latest allowed
#'   versions.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' lock()
#' lock(upgrade = TRUE)  # upgrade all packages to latest versions
#' }
lock <- function(upgrade = FALSE, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.logical(upgrade) && !is.na(upgrade) && length(upgrade) == 1L,
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  args <- "lock"
  if (isTRUE(upgrade)) {
    args <- c(args, "--upgrade")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
