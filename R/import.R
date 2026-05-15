#' Import renv lockfile to create uvr.toml
#'
#' Converts \code{renv.lock} to \code{uvr.toml}.
#' Equivalent to \code{uvr import} on the command line.
#'
#' @param do_lock If \code{TRUE}, create \code{uvr.lock} as well.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
import <- function(do_lock = FALSE, bin = NULL, dir = NULL, quiet = FALSE) {
  stopifnot(
    is.logical(do_lock) && !is.na(do_lock) && length(do_lock) == 1L,
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  args <- "import"
  if (isTRUE(do_lock)) {
    args <- c(args, "--lock")
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
