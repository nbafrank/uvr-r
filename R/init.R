#' Initialize a new uvr project
#'
#' Creates a \code{uvr.toml} manifest and \code{.uvr/library/} directory.
#' Also generates \code{.Rprofile} code to link to the \code{.uvr/library/} on session start.
#' Equivalent to \code{uvr init} on the command line.
#'
#' @param name Optional project name. Defaults to the current directory name.
#' @param r_version Optional R version constraint, e.g. \code{">=4.3.0"}.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
#' @examples
#' \dontrun{
#' init()
#' init(name = "my-project", r_version = ">=4.3.0")
#' }
init <- function(name = NULL, r_version = NULL, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.null(name) || (is.character(name) && length(name) == 1L),
    is.null(r_version) || (is.character(r_version) && length(r_version) == 1L),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- "init"
  if (!is.null(name)) {
    args <- c(args, name)
  }
  if (!is.null(r_version)) {
    args <- c(args, "--r-version", r_version)
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
