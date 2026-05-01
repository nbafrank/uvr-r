#' Import renv lockfile to create uvr.toml
#'
#' Converts \code{renv.lock} to \code{uvr.toml}.
#' Equivalent to \code{uvr import} on the command line.
#'
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
import <- function(dir = NULL, quiet = FALSE) {
  stopifnot(
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )
  
  args <- "import"
  if (isTRUE(lock)) {
    args <- c(args, "--lock")
  }
  run_uvr(args, dir = dir, quiet = quiet)
}
