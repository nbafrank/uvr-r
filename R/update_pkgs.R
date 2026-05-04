#' Update installed packages to the latest allowed versions
#'
#' Convenience wrapper that re-resolves the lockfile with
#' \code{lock(upgrade = TRUE)} and then installs the updates with
#' \code{sync()}. Equivalent to running \code{uvr lock --upgrade && uvr sync}
#' on the command line.
#'
#' @param sync If \code{TRUE}, install the updated packages using \code{sync()}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
#' @examples
#' \dontrun{
#' # Update the lockfile and install updated packages
#' update_pkgs()
#'
#' # Don't install updated packages, just update the lockfile
#' update_pkgs(sync = FALSE)
#' }
update_pkgs <- function(sync = TRUE, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.logical(sync) && length(sync) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  lock(upgrade = TRUE, bin = bin, dir = dir, quiet = quiet)
  if (isTRUE(sync)) sync(bin = bin, dir = dir, quiet = quiet)
}
