#' Remove packages from the project
#'
#' Removes one or more packages from the manifest and updates the lockfile.
#' Equivalent to \code{uvr remove} on the command line.
#'
#' @inheritParams add
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
#' @examples
#' \dontrun{
#' remove_pkgs("ggplot2")
#' remove_pkgs(c("dplyr", "tidyr"))
#' }
remove_pkgs <- function(packages, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(packages) && length(packages) > 0L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("remove", packages)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
