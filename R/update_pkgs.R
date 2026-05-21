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
#' @family package managers
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
  .validate_flags(list(do_sync = do_sync, quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)

  lock(upgrade = TRUE, bin = bin, dir = dir, quiet = quiet)
  if (isTRUE(do_sync)) sync(bin = bin, dir = dir, quiet = quiet)
}
