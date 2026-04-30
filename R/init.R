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
init <- function(name = NULL, r_version = NULL, dir = NULL, quiet = FALSE) {
  args <- "init"
  if (!is.null(name)) {
    args <- c(args, name)
  }
  if (!is.null(r_version)) {
    args <- c(args, "--r-version", r_version)
  }
  run_uvr(args, dir = dir, quiet = quiet)
}
