#' Diagnose environment issues (R, build tools, project status)
#'
#' Equivalent to \code{uvr doctor} on the command line.
#'
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress output.
#' @return Invisible \code{TRUE} on success.
#' @export
doctor <- function(dir = NULL, quiet = FALSE) {
  args <- c("doctor")
  run_uvr(args, dir = dir, quiet = quiet)
}
