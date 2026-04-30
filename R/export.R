#' Export lockfile to renv.lock format
#'
#' Converts \code{uvr.lock} to \code{renv.lock}.
#' Equivalent to \code{uvr export} on the command line.
#'
#' @param out_file Name of the output lockfile. Defaults to \code{"renv.lock"}.
#' @param dir Optional working directory. Defaults to \code{getwd()}.
#' @param quiet If \code{TRUE}, suppress output.
#' @return Invisible \code{TRUE} on success.
#' @export
export <- function(out_file = "renv.lock", dir = NULL, quiet = FALSE) {
  stopifnot(
    length(out_file) == 1L,
    is.character(out_file)
  )
  args <- "export"
  if (out_file != "renv.lock") {
    args <- c(args, "-o", out_file)
  }
  run_uvr(args, dir = dir, quiet = quiet)
}
