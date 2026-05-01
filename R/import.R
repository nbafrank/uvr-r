#' Import renv lockfile to create uvr.toml
#'
#' Converts \code{renv.lock} to \code{uvr.toml}.
#' Equivalent to \code{uvr import} on the command line.
#'
#' @param lock If \code{TRUE}, create \code{uvr.lock} as well.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
import <- function(lock = FALSE, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.logical(lock) && length(lock) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- "import"
  if (isTRUE(lock)) {
    args <- c(args, "--lock")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
