#' Install an R version
#'
#' Downloads and installs a specific R version to \code{~/.uvr/r-versions/}.
#' Equivalent to \code{uvr r install <version>} on the command line.
#'
#' @param version R version string, e.g. \code{"4.4.2"}.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
r_install <- function(version, bin = NULL, quiet = FALSE) {
  stopifnot(
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.character(version) && length(version) == 1L,
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("r", "install", version)
  run_uvr(args, bin = bin, quiet = quiet)
}

#' List R versions
#'
#' Shows installed R versions. Use \code{all = TRUE} to show all available
#' versions from CRAN.
#' Equivalent to \code{uvr r list} on the command line.
#'
#' @param all If \code{TRUE}, show all available versions (not just installed).
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
r_list <- function(all = FALSE, bin = NULL, quiet = FALSE) {
  stopifnot(
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.logical(all) && length(all) == 1L,
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("r", "list")
  if (isTRUE(all)) {
    args <- c(args, "--all")
  }
  run_uvr(args, bin = bin, quiet = quiet)
}

#' Set the R version constraint
#'
#' Sets the R version constraint in \code{uvr.toml}.
#' Equivalent to \code{uvr r use <version>} on the command line.
#'
#' @param version Version constraint, e.g. \code{">=4.3.0"} or \code{"4.4.2"}.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
r_use <- function(version, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(version) && length(version) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("r", "use", version)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}

#' Pin the R version
#'
#' Writes an exact R version to the \code{.r-version} file.
#' Equivalent to \code{uvr r pin <version>} on the command line.
#'
#' @param version Exact R version, e.g. \code{"4.4.2"}.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
r_pin <- function(version, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.character(version) && length(version) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("r", "pin", version)
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
