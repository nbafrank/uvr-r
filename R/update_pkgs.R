#' Update installed packages to the latest allowed versions
#'
#' Convenience wrapper that re-resolves the lockfile with
#' \code{lock(upgrade = TRUE)} and then installs the updates with
#' \code{sync()}. Equivalent to running \code{uvr lock --upgrade && uvr sync}
#' on the command line.
#'
#' @param do_sync If \code{TRUE}, install the updated packages using \code{sync()}.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @export
#' @examples
#' \dontrun{
#' # Update the lockfile and install updated packages
#' update_pkgs()
#'
#' # Don't install updated packages, just update the lockfile
#' update_pkgs(do_sync = FALSE)
#' }
update_pkgs <- function(do_sync = TRUE, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.logical(do_sync) && !is.na(do_sync) && length(do_sync) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  lock(upgrade = TRUE, bin = bin, dir = dir, quiet = quiet)
  if (isTRUE(do_sync)) sync(bin = bin, dir = dir, quiet = quiet)
}
