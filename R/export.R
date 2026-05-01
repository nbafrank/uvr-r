#' Export lockfile to renv.lock format
#'
#' Converts \code{uvr.lock} to \code{renv.lock}.
#' Equivalent to \code{uvr export} on the command line.
#'
#' @param out_file Name of the output lockfile. Defaults to \code{"renv.lock"}.
#' @inheritParams run_uvr
#' @return Invisible \code{TRUE} on success.
#' @export
export <- function(
  out_file = "renv.lock",
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  stopifnot(
    length(out_file) == 1L && is.character(out_file),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && length(quiet) == 1L
  )

  args <- "export"
  if (out_file != "renv.lock") {
    args <- c(args, "-o", out_file)
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
