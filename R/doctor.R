#' Diagnose environment issues (R, build tools, project status)
#'
#' Equivalent to \code{uvr doctor} on the command line.
#'
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family uvr setup functions
#' @export
doctor <- function(bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  args <- c("doctor")
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
