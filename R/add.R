#' Add packages to the project
#'
#' Adds one or more packages to the manifest, updates the lockfile, and
#' installs them. Equivalent to \code{uvr add} on the command line.
#'
#' @param packages Character vector of package names (e.g. \code{c("ggplot2", "tidymodels@@>=1.0.0", "user/repo@@main")}).
#' @param dev If \code{TRUE}, add as dev dependencies.
#' @param bioc If \code{TRUE}, packages come from Bioconductor.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
add <- function(
  packages,
  dev = FALSE,
  bioc = FALSE,
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  stopifnot(
    is.character(packages) && length(packages) > 0L,
    is.logical(dev) && length(dev) == 1L,
    is.logical(bioc) && length(bioc) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("add", packages)
  if (isTRUE(dev)) {
    args <- c(args, "--dev")
  }
  if (isTRUE(bioc)) {
    args <- c(args, "--bioc")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
