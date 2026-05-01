#' Diagnose environment issues (R, build tools, project status)
#'
#' Equivalent to \code{uvr doctor} on the command line.
#'
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
doctor <- function(dir = NULL, quiet = FALSE) {
  stopifnot(
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- c("doctor")
  run_uvr(args, dir = dir, quiet = quiet)
}
