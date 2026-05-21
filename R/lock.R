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
  .validate_flags(list(upgrade = upgrade, quiet = quiet))
  .validate_single_characters(list(bin = bin, dir = dir), null_ok = TRUE)

  args <- "lock"
  if (isTRUE(upgrade)) {
    args <- c(args, "--upgrade")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
