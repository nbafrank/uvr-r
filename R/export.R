#' Export lockfile to renv.lock format
#'
#' Converts \code{uvr.lock} to \code{renv.lock}.
#' Equivalent to \code{uvr export} on the command line.
#'
#' @param out_file Name of the output lockfile. Defaults to \code{NULL}, returning the output via the console instead of writing to a file.
#' @inheritParams run_uvr
#' @inherit run_uvr return
#' @family package managers
#' @export
#' @examples
#' \dontrun{
#' lock_lines <- export() # store as variable
#' export(out_file = "renv.lock") # export to file
#' }
export <- function(
  out_file = NULL,
  bin = NULL,
  dir = NULL,
  quiet = FALSE
) {
  stopifnot(
    is.null(out_file) || (length(out_file) == 1L && is.character(out_file)),
    is.null(bin) || (is.character(bin) && length(bin) == 1L),
    is.null(dir) || (is.character(dir) && length(dir) == 1L),
    is.logical(quiet) && !is.na(quiet) && length(quiet) == 1L
  )

  args <- "export"
  if (!is.null(out_file)) {
    args <- c(args, "-o", out_file)
  }
  run_uvr(args, bin = bin, dir = dir, quiet = quiet)
}
